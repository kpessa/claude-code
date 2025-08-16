#!/bin/bash

# Type check and lint hook for Claude Code
# Runs after Claude finishes implementing features
# Auto-fixes what it can, prompts Claude to fix the rest

# Parse the JSON input from stdin
INPUT=$(cat)
STOP_HOOK_ACTIVE=$(echo "$INPUT" | jq -r '.stop_hook_active // false')

# Prevent infinite loops
if [ "$STOP_HOOK_ACTIVE" = "true" ]; then
    exit 0
fi

# Function to find the project root (where package.json is)
find_project_root() {
    local dir="$PWD"
    while [ "$dir" != "/" ]; do
        if [ -f "$dir/package.json" ]; then
            echo "$dir"
            return 0
        fi
        dir=$(dirname "$dir")
    done
    return 1
}

# Find project root
PROJECT_ROOT=$(find_project_root)
if [ -z "$PROJECT_ROOT" ]; then
    # No package.json found, this isn't a JS/TS project
    exit 0
fi

cd "$PROJECT_ROOT"

# Detect package manager (prefer pnpm)
if [ -f "pnpm-lock.yaml" ]; then
    PM="pnpm"
elif [ -f "yarn.lock" ]; then
    PM="yarn"
elif [ -f "package-lock.json" ]; then
    PM="npm"
else
    # Default to pnpm as user preference
    PM="pnpm"
fi

# Check if lint and type-check scripts exist
HAS_LINT=$(jq -r '.scripts.lint // empty' package.json)
HAS_TYPECHECK=$(jq -r '.scripts["type-check"] // .scripts.typecheck // .scripts.tsc // empty' package.json)

ERRORS=""
FIXED_SOMETHING=false

# Try to auto-fix with ESLint if lint script exists
if [ -n "$HAS_LINT" ]; then
    # First try to auto-fix
    if $PM run lint -- --fix 2>/dev/null; then
        FIXED_SOMETHING=true
    fi
    
    # Check if there are still lint errors
    if ! $PM run lint 2>/dev/null; then
        LINT_OUTPUT=$($PM run lint 2>&1 || true)
        ERRORS="${ERRORS}ESLint errors found:\n${LINT_OUTPUT}\n\n"
    fi
fi

# Run type checking if script exists
if [ -n "$HAS_TYPECHECK" ]; then
    # Determine which script name to use
    if [ -n "$(jq -r '.scripts["type-check"] // empty' package.json)" ]; then
        TYPECHECK_SCRIPT="type-check"
    elif [ -n "$(jq -r '.scripts.typecheck // empty' package.json)" ]; then
        TYPECHECK_SCRIPT="typecheck"
    else
        TYPECHECK_SCRIPT="tsc"
    fi
    
    if ! $PM run "$TYPECHECK_SCRIPT" 2>/dev/null; then
        TSC_OUTPUT=$($PM run "$TYPECHECK_SCRIPT" 2>&1 || true)
        ERRORS="${ERRORS}TypeScript errors found:\n${TSC_OUTPUT}\n"
    fi
fi

# If we have errors, block and ask Claude to fix them
if [ -n "$ERRORS" ]; then
    echo "{\"decision\": \"block\", \"reason\": \"Code quality issues detected. Please fix the following errors:\\n\\n${ERRORS}\"}"
    exit 0
fi

# All good, let Claude finish
exit 0