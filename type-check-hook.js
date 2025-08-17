#!/usr/bin/env node

/**
 * Cross-platform type-check and lint hook for Claude Code
 * Works on Windows, macOS, and Linux
 * Runs after Claude finishes implementing features
 * Auto-fixes what it can, prompts Claude to fix the rest
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Read JSON input from stdin
let inputData = '';
process.stdin.setEncoding('utf8');

process.stdin.on('data', (chunk) => {
    inputData += chunk;
});

process.stdin.on('end', () => {
    try {
        processHook(inputData);
    } catch (error) {
        // If there's an error, just exit silently to not block Claude
        console.error(error);
        process.exit(0);
    }
});

function processHook(input) {
    let parsedInput = {};
    
    try {
        parsedInput = JSON.parse(input);
    } catch (e) {
        // If we can't parse input, just continue
    }

    // Prevent infinite loops
    if (parsedInput.stop_hook_active === true) {
        process.exit(0);
    }

    // Find project root (where package.json is)
    const projectRoot = findProjectRoot(process.cwd());
    if (!projectRoot) {
        // No package.json found, this isn't a JS/TS project
        process.exit(0);
    }

    process.chdir(projectRoot);

    // Read package.json to check for scripts
    const packageJson = JSON.parse(fs.readFileSync('package.json', 'utf8'));
    const scripts = packageJson.scripts || {};

    // Detect package manager
    const pm = detectPackageManager(projectRoot);

    let errors = [];
    let fixedSomething = false;

    // Check for lint script
    const lintScript = scripts.lint || scripts.eslint;
    if (lintScript) {
        const { fixed, remainingErrors } = runLinting(pm);
        fixedSomething = fixedSomething || fixed;
        if (remainingErrors) {
            errors.push(`ESLint errors found:\n${remainingErrors}`);
        }
    }

    // Check for type-check script
    const typeCheckScript = scripts['type-check'] || scripts.typecheck || scripts.tsc;
    if (typeCheckScript) {
        const typeErrors = runTypeCheck(pm, scripts);
        if (typeErrors) {
            errors.push(`TypeScript errors found:\n${typeErrors}`);
        }
    }

    // Check for prettier if configured
    const prettierScript = scripts.prettier || scripts.format;
    if (prettierScript && !errors.length) {
        try {
            // Try to format files
            execSync(`${pm} run ${prettierScript.includes('--write') ? prettierScript.split(' ')[0] : prettierScript} --write .`, {
                stdio: 'pipe',
                encoding: 'utf8'
            });
            fixedSomething = true;
        } catch (e) {
            // Prettier errors are non-blocking
        }
    }

    // If we have errors, block and ask Claude to fix them
    if (errors.length > 0) {
        const response = {
            decision: 'block',
            reason: `Code quality issues detected. Please fix the following errors:\n\n${errors.join('\n\n')}`
        };
        console.log(JSON.stringify(response));
        process.exit(0);
    }

    // All good, let Claude finish
    process.exit(0);
}

function findProjectRoot(startDir) {
    let dir = startDir;
    
    while (dir !== path.parse(dir).root) {
        if (fs.existsSync(path.join(dir, 'package.json'))) {
            return dir;
        }
        dir = path.dirname(dir);
    }
    
    return null;
}

function detectPackageManager(projectRoot) {
    // Check for lock files to determine package manager
    if (fs.existsSync(path.join(projectRoot, 'pnpm-lock.yaml'))) {
        return 'pnpm';
    } else if (fs.existsSync(path.join(projectRoot, 'yarn.lock'))) {
        return 'yarn';
    } else if (fs.existsSync(path.join(projectRoot, 'package-lock.json'))) {
        return 'npm';
    }
    
    // Check if pnpm is available (user preference)
    try {
        execSync('pnpm --version', { stdio: 'pipe' });
        return 'pnpm';
    } catch (e) {
        // pnpm not available
    }
    
    // Default to npm
    return 'npm';
}

function runLinting(pm) {
    let fixed = false;
    let remainingErrors = null;

    try {
        // First try to auto-fix
        execSync(`${pm} run lint -- --fix`, {
            stdio: 'pipe',
            encoding: 'utf8'
        });
        fixed = true;
    } catch (e) {
        // Auto-fix might have partially succeeded
        fixed = true;
    }

    // Check if there are still lint errors
    try {
        execSync(`${pm} run lint`, {
            stdio: 'pipe',
            encoding: 'utf8'
        });
    } catch (e) {
        // Capture lint errors
        remainingErrors = e.stdout || e.message;
        
        // Truncate very long error messages
        if (remainingErrors && remainingErrors.length > 2000) {
            const lines = remainingErrors.split('\n');
            const relevantLines = lines.filter(line => 
                line.includes('error') || 
                line.includes('Error') || 
                line.includes('warning') ||
                line.includes('.ts') ||
                line.includes('.js') ||
                line.includes('.tsx') ||
                line.includes('.jsx') ||
                line.includes('.svelte')
            ).slice(0, 20);
            
            remainingErrors = relevantLines.join('\n') + '\n\n[Output truncated - showing first 20 relevant lines]';
        }
    }

    return { fixed, remainingErrors };
}

function runTypeCheck(pm, scripts) {
    // Determine which script name to use
    let typeCheckScript = 'typecheck';
    if (scripts['type-check']) {
        typeCheckScript = 'type-check';
    } else if (scripts.typecheck) {
        typeCheckScript = 'typecheck';
    } else if (scripts.tsc) {
        typeCheckScript = 'tsc';
    } else {
        return null; // No type-check script found
    }

    try {
        execSync(`${pm} run ${typeCheckScript}`, {
            stdio: 'pipe',
            encoding: 'utf8'
        });
        return null; // No errors
    } catch (e) {
        // Capture TypeScript errors
        let errors = e.stdout || e.message;
        
        // Truncate very long error messages
        if (errors && errors.length > 2000) {
            const lines = errors.split('\n');
            const relevantLines = lines.filter(line => 
                line.includes('error TS') || 
                line.includes('Error') ||
                line.includes('.ts') ||
                line.includes('.tsx') ||
                line.includes('.svelte')
            ).slice(0, 20);
            
            errors = relevantLines.join('\n') + '\n\n[Output truncated - showing first 20 relevant lines]';
        }
        
        return errors;
    }
}

// Handle timeout for reading stdin
setTimeout(() => {
    // If no input received within 5 seconds, just exit
    process.exit(0);
}, 5000);