---
description: Progressively test webapp in dev mode with transparent fixes and full visibility
---

# Test - Interactive Progressive Testing

Run your webapp in development mode and progressively test functionality with full visibility into what's being tested and fixed. All fixes happen on the main thread with your approval.

## Usage:
- `/test` - Interactive testing with prompts (default)
- `/test --auto-fix` - Apply fixes without prompting (except destructive)
- `/test --dry-run` - Show what would be fixed without applying
- `/test --verbose` - Show detailed output for debugging
- `/test --level=3` - Test up to specific level only
- `/test --skip-e2e` - Skip E2E tests (faster)
- `/test --create-tests` - Generate missing test files

## Progressive Testing Levels:

### 🟢 Level 1: Server Health
- Dev server starts successfully
- Port is accessible
- No critical build errors

### 🟡 Level 2: Basic Functionality
- Homepage returns 200 status
- No console errors
- Static assets load properly

### 🟠 Level 3: Routes & Navigation
- All expected routes accessible
- No unexpected 404s
- Client-side routing works

### 🔵 Level 4: API & Data
- API endpoints respond correctly
- Database connections work
- Authentication flows function

### 🟣 Level 5: Full Test Suite
- Unit tests pass
- Integration tests pass
- E2E tests pass (if available)

## Interactive Testing Workflow:

### Phase 1: Project Detection (Transparent)

```
🔍 Analyzing project structure...
   ✓ Found: next.config.js (Next.js project)
   ✓ Found: playwright.config.ts (Playwright tests)
   ✓ Found: package.json scripts
   
📊 Project Summary:
   Framework: Next.js 14 (App Router)
   Test Runner: Playwright
   Dev Command: npm run dev
   Test Command: npm test
```

### Phase 2: Start Dev Server (Interactive)

```
🚀 Starting development server...

⚠️  Port 3000 is already in use
   Process: node (PID: 12345)
   
➡️  Kill existing process and continue? [Y/n]: Y
   ✓ Killed process on port 3000

📦 Checking dependencies...
   ✓ All dependencies installed

🔄 Starting server...
   $ npm run dev
   
   > my-app@0.1.0 dev
   > next dev
   
   ✓ Ready on http://localhost:3000

✅ Dev server is running!
```

### Phase 3: Progressive Testing (Interactive)

#### Level 1: Server Health Check
```
🧪 LEVEL 1: Server Health Check
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔍 Testing server response...
   GET http://localhost:3000
   
   ✓ Server responded (200 OK)
   ✓ Response time: 145ms
   
✅ Level 1 PASSED - Server is healthy
```

If server fails:
```
❌ Server not responding

🔍 Detected issue: Connection refused
💡 Suggested fixes:
   1. Restart dev server
   2. Clear build cache
   3. Reinstall dependencies
   
➡️  Apply fix #1? [Y/n/skip]: 
```

#### Level 2: Basic Functionality
```
🧪 LEVEL 2: Basic Functionality
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔍 Loading homepage...
   ✓ Page loaded successfully
   ✓ Title: "My App"
   
🔍 Checking for console errors...
   ⚠️ Found 2 console errors:
   
   1. "Failed to load resource: 404 /favicon.ico"
   2. "Warning: Each child should have unique key prop"
   
💡 Suggested fixes:
   1. Add missing favicon.ico
   2. Fix React key warnings in components
   
➡️  Apply fixes? [Y/n/skip]: n
   ⚠️ Continuing with warnings
   
✅ Level 2 PASSED (with warnings)
```

#### Level 3: Route Testing
```
🧪 LEVEL 3: Routes & Navigation
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔍 Detecting routes from codebase...
   Found 5 routes:
   • / (homepage)
   • /about
   • /dashboard
   • /api/health
   • /api/users
   
🔍 Testing each route...
   ✓ / .............. 200 OK (125ms)
   ✓ /about ......... 200 OK (89ms)
   ❌ /dashboard ..... 401 Unauthorized
   ✓ /api/health .... 200 OK (12ms)
   ❌ /api/users ..... 500 Internal Error
   
🔍 Found 2 failing routes

💡 Issue 1: /dashboard returns 401
   Cause: Missing authentication
   Fix: Add auth middleware bypass for testing
   
💡 Issue 2: /api/users returns 500
   Cause: Database connection error
   Fix: Set up test database
   
➡️  View detailed errors? [y/N]: 
➡️  Continue testing? [Y/n]: Y

⚠️ Level 3 PASSED with issues (3/5 routes working)
```

#### Level 4: API & Data Testing
```
🧪 LEVEL 4: API & Data
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔍 Testing API endpoints...
   ✓ /api/health ... Response: {"status":"healthy"}
   ✗ /api/users .... Error: ECONNREFUSED
   
🔍 Checking database connection...
   ✗ Database unreachable
   
💡 Detected issues:
   1. Database not running
   2. Missing DB environment variables
   
   Would you like to:
   [1] Start local database
   [2] Use in-memory database for testing
   [3] Skip database tests
   
➡️  Choice [1/2/3]: 2
   ✓ Configured in-memory test database
   ✓ Retrying API tests...
   ✓ All API endpoints working
   
✅ Level 4 PASSED (with test database)
```

#### Level 5: Full Test Suite
```
🧪 LEVEL 5: Full Test Suite
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔍 Found test runner: Playwright

📦 Running test suite...
   $ npx playwright test
   
   Running 15 tests using 3 workers
   
   [1/15] ✓ homepage loads without errors (1.2s)
   [2/15] ✓ navigation works (0.8s)
   [3/15] ✗ user login flow (2.1s)
   [4/15] ✓ API health check (0.3s)
   ...
   
   12 passed, 3 failed
   
💡 Test failures detected:

   1. user login flow
      Error: Timeout waiting for selector "#login-button"
      Fix: Update test selector or add data-testid
      
   2. checkout process
      Error: Expected price "$99" but got "$0"
      Fix: Mock API response in test
      
   3. mobile responsive
      Error: Menu not visible on mobile
      Fix: Add mobile menu component
      
➡️  Auto-fix test issues? [y/N]: y

🔧 Applying fixes...
   ✓ Updated test selectors
   ✓ Added API mocks
   ✓ Fixed mobile menu visibility
   
🔄 Re-running failed tests...
   ✓ All tests passing (15/15)
   
✅ Level 5 PASSED - All tests successful!
```

### Phase 4: Interactive Fix Application

When issues are detected, the command will:

1. **Show the issue clearly**
   ```
   🔍 Detected: Missing dependency 'axios'
   ```

2. **Explain the fix**
   ```
   💡 Fix: Install axios package
      Command: npm install axios
   ```

3. **Ask for confirmation** (unless --auto-fix)
   ```
   ➡️  Apply this fix? [Y/n]: 
   ```

4. **Show progress**
   ```
   🔧 Installing axios...
      added 5 packages in 2.341s
   ✓ Fix applied successfully
   ```

5. **Verify the fix**
   ```
   🔄 Re-testing...
   ✓ Issue resolved
   ```

### Phase 5: Common Fix Patterns

#### Missing Dependencies
```
🔍 Issue: Cannot find module 'lodash'
💡 Fix: npm install lodash
➡️  Apply? [Y/n]: Y
```

#### Port Conflicts
```
🔍 Issue: Port 3000 already in use
💡 Options:
   [1] Kill process on port 3000
   [2] Use different port (3001)
   [3] Cancel
➡️  Choice [1/2/3]: 1
```

#### Type Errors
```
🔍 Issue: TypeScript errors (5 errors)
💡 Fixes available:
   ✓ Add missing type definitions
   ✓ Fix incorrect types
   ✓ Add @ts-ignore (quick fix)
➡️  Apply all fixes? [Y/n/select]: 
```

#### Build/Cache Issues  
```
🔍 Issue: Build failed - stale cache
💡 Fix: Clear build caches
   • .next/
   • node_modules/.cache/
   • dist/
➡️  Clear caches and rebuild? [Y/n]: Y
```

### Command Line Arguments

#### --auto-fix
Automatically apply non-destructive fixes:
```bash
/test --auto-fix

# Will auto-apply:
✓ Install missing dependencies
✓ Clear caches
✓ Fix lint errors
✓ Update import paths

# Will still prompt for:
⚠️ Deleting files
⚠️ Database migrations
⚠️ Breaking changes
```

#### --dry-run  
Show what would be fixed without applying:
```bash
/test --dry-run

🔍 Dry run mode - no changes will be made

 Would fix:
 • Install axios
 • Clear .next cache
 • Add missing favicon.ico
 • Fix 3 TypeScript errors
```

#### --verbose
Show detailed output for debugging:
```bash
/test --verbose

[DEBUG] Starting server on port 3000
[DEBUG] Server PID: 12345
[DEBUG] Waiting for server ready...
[DEBUG] Server responded after 1.2s
[DEBUG] Running health check...
```

### Batch Fix Mode

When multiple similar issues are found:

```
🔍 Found 5 similar issues:

📦 Missing dependencies:
   1. axios
   2. lodash
   3. date-fns
   4. uuid
   5. classnames
   
➡️  Install all missing dependencies? [Y/n/select]: Y

🔧 Installing 5 packages...
   ✓ axios@1.6.0
   ✓ lodash@4.17.21
   ✓ date-fns@3.0.0
   ✓ uuid@9.0.1
   ✓ classnames@2.3.2
   
✅ All dependencies installed
```

### Smart Fix Suggestions

The test command learns from your project:

```
🤖 Based on your project patterns:
   • You use Tailwind for styling
   • You prefer named exports
   • You use async/await over promises
   
   Suggested fix will follow these patterns.
```

## Error Recovery Strategies:

### Intelligent Error Detection

The command recognizes common patterns:

| Error | Detection | Fix Strategy |
|-------|-----------|-------------|
| `EADDRINUSE` | Port in use | Kill process or use alt port |
| `Cannot find module` | Missing dep | Install package |
| `TypeError: Cannot read` | Null reference | Add null checks |
| `ECONNREFUSED` | Service down | Start service or mock |
| `ENOMEM` | Out of memory | Increase heap size |
| `404 on /favicon.ico` | Missing file | Create or ignore |
| React key warnings | Missing keys | Add unique keys |
| Hydration mismatch | SSR issue | Fix initial state |

## Success Output:

```
🧪 Test Report
════════════════════════════════════════

✅ Level 1: Server Health ........ PASSED
✅ Level 2: Basic Functionality ... PASSED 
⚠️  Level 3: Routes & Navigation .. PASSED (with 2 warnings)
✅ Level 4: API & Data ............ PASSED
✅ Level 5: Test Suite ............ PASSED (15/15 tests)

📈 Metrics:
   • Server Start Time: 2.1s
   • Page Load Time: 245ms  
   • Test Coverage: 76%
   • Bundle Size: 287kb
   
🔧 Fixes Applied:
   • Installed 3 missing dependencies
   • Fixed 5 TypeScript errors
   • Created health endpoint
   • Cleared build cache

🚀 Development server running at http://localhost:3000

✅ All systems operational!
```

## Integration with Your Workflow:

### Quick Commands
```bash
# Full interactive test
/test

# Fast auto-fix mode
/test --auto-fix

# Check without changes
/test --dry-run

# Test specific level
/test --level=3

# Skip slow E2E tests
/test --skip-e2e
```

### Workflow Combinations
```bash
# Before shipping code
/test --auto-fix && /commit && /push

# After pulling changes  
/pull && /test

# Start of work session
/resume && /test --level=2

# Debugging specific issue
/test --verbose --level=3
```

## Interactive Features:

### Smart Prompting
- **Y/n** - Yes by default (just press Enter)
- **y/N** - No by default
- **[1/2/3]** - Choose numbered option
- **[Y/n/select]** - Select individual items
- **[skip]** - Skip this fix, continue testing

### Safety Features
- 🛡️ Never deletes code without confirmation
- 🔒 Backs up files before major changes
- ⚠️  Warns about breaking changes
- 🔄 Can undo last fix with `/test --undo`

### Progress Indicators
- 🔍 Analyzing...
- 🔧 Fixing...
- 🔄 Retrying...
- ✓ Success
- ✗ Failed
- ⚠️ Warning

## Notes:

- Full transparency - see every test and fix
- Interactive by default, automated with flags
- Non-destructive fixes unless confirmed
- Learns from your project patterns
- Keeps server running after success

$ARGUMENTS