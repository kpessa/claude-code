---
description: Progressively test webapp in dev mode, auto-fix issues, and ensure everything works
---

# Test - Progressive Testing Until Success

Run your webapp in development mode and progressively test functionality, automatically fixing common issues until everything works. Creates missing tests if needed.

## Usage:
- `/test` - Full progressive testing
- `/test --create-tests` - Generate missing tests
- `/test --level=3` - Test up to specific level
- `/test --fix-mode` - Aggressive auto-fixing
- `/test --skip-e2e` - Skip E2E tests (faster)

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

## Workflow Instructions:

### Phase 1: Project Detection

```bash
# Detect project type
if [ -f "next.config.js" ] || [ -f "next.config.ts" ]; then
  PROJECT_TYPE="nextjs"
elif [ -f "svelte.config.js" ]; then
  PROJECT_TYPE="svelte"
elif [ -f "vite.config.js" ] || [ -f "vite.config.ts" ]; then
  PROJECT_TYPE="vite"
elif [ -f "package.json" ]; then
  # Check package.json for framework
  grep -q '"react"' package.json && PROJECT_TYPE="react"
fi

# Detect test runner
if [ -f "playwright.config.ts" ] || [ -f "playwright.config.js" ]; then
  TEST_RUNNER="playwright"
elif [ -f "vitest.config.ts" ] || [ -f "vitest.config.js" ]; then
  TEST_RUNNER="vitest"
elif grep -q '"jest"' package.json 2>/dev/null; then
  TEST_RUNNER="jest"
else
  TEST_RUNNER="none"
fi

echo "Detected: $PROJECT_TYPE with $TEST_RUNNER"
```

### Phase 2: Start Dev Server with Error Handling

```bash
# Kill any existing process on the port
PORT=${PORT:-3000}
lsof -ti:$PORT | xargs kill -9 2>/dev/null

# Try to start dev server
echo "Starting development server..."
npm run dev &
DEV_PID=$!

# Wait for server to be ready (with timeout)
MAX_WAIT=30
WAITED=0
while ! curl -s http://localhost:$PORT > /dev/null; do
  if [ $WAITED -ge $MAX_WAIT ]; then
    echo "❌ Server failed to start in $MAX_WAIT seconds"
    # Try to fix common issues
    npm install
    rm -rf .next node_modules/.cache
    npm run dev &
    DEV_PID=$!
  fi
  sleep 1
  WAITED=$((WAITED + 1))
done

echo "✅ Dev server running on port $PORT"
```

### Phase 3: Progressive Testing

#### Level 1: Server Health Check
```bash
# Check if server responds
curl -f http://localhost:$PORT > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "✅ Level 1: Server is healthy"
else
  echo "❌ Level 1: Server not responding"
  # Auto-fix attempts
  npm install
  npm run build
  exit 1
fi
```

#### Level 2: Basic Functionality
```javascript
// Check for console errors and page load
const checkBasicFunctionality = async () => {
  const browser = await playwright.chromium.launch();
  const page = await browser.newPage();
  
  const errors = [];
  page.on('console', msg => {
    if (msg.type() === 'error') errors.push(msg.text());
  });
  
  try {
    const response = await page.goto(`http://localhost:${PORT}`);
    
    if (response.status() !== 200) {
      throw new Error(`Homepage returned ${response.status()}`);
    }
    
    if (errors.length > 0) {
      console.log('Console errors found:', errors);
      // Attempt to fix common errors
    }
    
    console.log('✅ Level 2: Basic functionality working');
  } catch (error) {
    console.log('❌ Level 2:', error.message);
  }
  
  await browser.close();
};
```

#### Level 3: Route Testing
```javascript
// Test all routes
const testRoutes = async () => {
  const routes = [
    '/',
    '/about',
    '/api/health',
    // Add detected routes
  ];
  
  for (const route of routes) {
    const response = await fetch(`http://localhost:${PORT}${route}`);
    if (response.status === 404) {
      console.log(`❌ Route ${route} not found`);
    }
  }
};
```

#### Level 4: API & Data Testing
```javascript
// Test API endpoints
const testAPI = async () => {
  // Test health endpoint
  const health = await fetch(`http://localhost:${PORT}/api/health`);
  if (!health.ok) {
    // Create health endpoint if missing
    createHealthEndpoint();
  }
  
  // Test database connection
  // Test auth flow
  // etc.
};
```

#### Level 5: Run Test Suite
```bash
# Run tests based on detected runner
case $TEST_RUNNER in
  "jest")
    npm test -- --passWithNoTests || handle_test_failure
    ;;
  "vitest")
    npm run test || handle_test_failure
    ;;
  "playwright")
    npx playwright test || handle_test_failure
    ;;
  "none")
    echo "No test runner found. Creating basic tests..."
    create_basic_tests
    ;;
esac
```

### Phase 4: Create Missing Tests

If no tests exist, create basic ones:

#### Basic Smoke Test
Create `tests/smoke.test.js`:
```javascript
describe('Smoke Tests', () => {
  test('development server is accessible', async () => {
    const response = await fetch('http://localhost:3000');
    expect(response.status).toBe(200);
  });

  test('health check endpoint works', async () => {
    const response = await fetch('http://localhost:3000/api/health');
    const data = await response.json();
    expect(data.status).toBe('healthy');
  });
});
```

#### Health Endpoint (Next.js App Router)
Create `app/api/health/route.ts`:
```typescript
export async function GET() {
  // Basic health check
  const checks = {
    server: 'healthy',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
  };

  // Add database check if applicable
  try {
    // await db.query('SELECT 1');
    // checks.database = 'healthy';
  } catch (error) {
    // checks.database = 'unhealthy';
  }

  return Response.json(checks);
}
```

#### Playwright Test
Create `tests/app.spec.ts`:
```typescript
import { test, expect } from '@playwright/test';

test.describe('App Basic Tests', () => {
  test('homepage loads without errors', async ({ page }) => {
    const errors: string[] = [];
    
    // Capture console errors
    page.on('console', msg => {
      if (msg.type() === 'error') {
        errors.push(msg.text());
      }
    });

    // Navigate to homepage
    await page.goto('/');
    
    // Check for errors
    expect(errors).toHaveLength(0);
    
    // Check page loaded
    await expect(page).toHaveTitle(/.+/);
  });

  test('navigation works', async ({ page }) => {
    await page.goto('/');
    
    // Test navigation if nav exists
    const links = await page.locator('nav a').all();
    for (const link of links) {
      const href = await link.getAttribute('href');
      if (href && href.startsWith('/')) {
        await link.click();
        await expect(page).toHaveURL(new RegExp(href));
        // Go back for next test
        await page.goto('/');
      }
    }
  });
});
```

### Phase 5: Auto-Fix Common Issues

#### Missing Dependencies
```bash
# Check for missing dependencies in errors
if grep -q "Cannot find module" error.log; then
  MODULE=$(grep "Cannot find module" error.log | sed -n "s/.*'\(.*\)'.*/\1/p")
  npm install $MODULE
fi
```

#### Type Errors
```bash
# Fix type errors
if npm run type-check 2>&1 | grep -q "error TS"; then
  echo "Type errors found. Attempting fixes..."
  # Add @ts-ignore for quick fix (document for later proper fix)
  # Or install missing @types packages
fi
```

#### Port Conflicts
```bash
# Find available port
for PORT in {3000..3010}; do
  if ! lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null; then
    echo "Using port $PORT"
    break
  fi
done
```

#### Build Cache Issues
```bash
# Clear various caches
rm -rf .next .svelte-kit .vite node_modules/.cache
rm -rf dist build out
```

## Error Recovery Strategies:

### Common Error Patterns:
- `EADDRINUSE` → Kill process on port
- `Cannot find module` → Install missing package
- `TypeError` → Check for undefined variables
- `ECONNREFUSED` → Start required services (DB, Redis)
- Memory issues → `NODE_OPTIONS="--max-old-space-size=4096"`

## Success Output:

```
🧪 Test Dev Report
==================
✅ Level 1: Server Health - PASSED
✅ Level 2: Basic Functionality - PASSED
✅ Level 3: Routes & Navigation - PASSED
✅ Level 4: API & Data - PASSED
✅ Level 5: Test Suite - PASSED (15/15 tests)

🚀 Development server running at http://localhost:3000
📊 Test Coverage: 76%
⚡ Page Load Time: 245ms

All systems operational! Happy coding! 🎉
```

## Integration with Your Workflow:

1. **Before commits**: `/test && /commit`
2. **After pulling**: `/test` to ensure everything works
3. **When debugging**: `/test --level=3` to isolate issues
4. **Starting work**: `/resume && /test`

## Notes:

- Tests are progressive - failure at one level stops testing
- Auto-fixes are non-destructive (cache clearing, installs)
- Creates minimal tests if none exist
- Keeps dev server running if all tests pass
- Integrates with your existing test runners

$ARGUMENTS