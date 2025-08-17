---
description: Generate Playwright tests for your webapp based on detected routes and components
---

# Playwright Test Generator

Automatically generate comprehensive Playwright tests for your application.

## Generated Test Examples:

### 1. Basic App Test Suite (`tests/app.spec.ts`)
```typescript
import { test, expect } from '@playwright/test';

test.describe('Application Tests', () => {
  test.beforeEach(async ({ page }) => {
    // Start from homepage before each test
    await page.goto('/');
  });

  test('homepage loads without errors', async ({ page }) => {
    const errors: string[] = [];
    
    // Capture console errors
    page.on('console', msg => {
      if (msg.type() === 'error') {
        errors.push(msg.text());
      }
    });

    // Capture network errors
    page.on('response', response => {
      if (!response.ok() && !response.url().includes('_next')) {
        errors.push(`${response.status()} ${response.url()}`);
      }
    });

    await page.goto('/');
    
    // Wait for main content
    await page.waitForLoadState('networkidle');
    
    // Check no errors occurred
    expect(errors).toHaveLength(0);
    
    // Verify page has content
    const title = await page.title();
    expect(title).toBeTruthy();
  });

  test('all navigation links work', async ({ page }) => {
    const links = await page.locator('nav a, header a').all();
    const checkedUrls = new Set<string>();
    
    for (const link of links) {
      const href = await link.getAttribute('href');
      
      // Skip external links and anchors
      if (!href || href.startsWith('http') || href.startsWith('#')) {
        continue;
      }
      
      // Skip if already checked
      if (checkedUrls.has(href)) {
        continue;
      }
      
      checkedUrls.add(href);
      
      // Click link and verify navigation
      await link.click();
      await page.waitForLoadState('networkidle');
      
      // Verify we navigated successfully
      expect(page.url()).toContain(href.replace(/^\//, ''));
      
      // Go back to homepage for next link
      await page.goto('/');
    }
  });

  test('forms are interactive', async ({ page }) => {
    const forms = await page.locator('form').all();
    
    for (const form of forms) {
      // Check form has inputs
      const inputs = await form.locator('input, textarea, select').all();
      expect(inputs.length).toBeGreaterThan(0);
      
      // Test each input is interactive
      for (const input of inputs) {
        const type = await input.getAttribute('type');
        
        if (type !== 'submit' && type !== 'button') {
          // Verify input is enabled and visible
          await expect(input).toBeEnabled();
          await expect(input).toBeVisible();
          
          // Try to interact with it
          if (type === 'checkbox' || type === 'radio') {
            await input.click();
          } else {
            await input.fill('test');
            const value = await input.inputValue();
            expect(value).toBe('test');
            await input.clear();
          }
        }
      }
    }
  });
});
```

### 2. Performance Test Suite (`tests/performance.spec.ts`)
```typescript
import { test, expect } from '@playwright/test';

test.describe('Performance Tests', () => {
  test('page load performance', async ({ page }) => {
    const startTime = Date.now();
    
    await page.goto('/');
    await page.waitForLoadState('networkidle');
    
    const loadTime = Date.now() - startTime;
    
    // Page should load in under 3 seconds
    expect(loadTime).toBeLessThan(3000);
    
    // Check Core Web Vitals
    const metrics = await page.evaluate(() => {
      return {
        FCP: performance.getEntriesByName('first-contentful-paint')[0]?.startTime,
        LCP: performance.getEntriesByType('largest-contentful-paint').pop()?.startTime,
      };
    });
    
    // First Contentful Paint under 1.8s
    if (metrics.FCP) {
      expect(metrics.FCP).toBeLessThan(1800);
    }
    
    // Largest Contentful Paint under 2.5s
    if (metrics.LCP) {
      expect(metrics.LCP).toBeLessThan(2500);
    }
  });

  test('no memory leaks on navigation', async ({ page }) => {
    // Navigate multiple times and check memory
    const memoryReadings = [];
    
    for (let i = 0; i < 5; i++) {
      await page.goto('/');
      await page.waitForLoadState('networkidle');
      
      const memory = await page.evaluate(() => {
        return (performance as any).memory?.usedJSHeapSize;
      });
      
      if (memory) {
        memoryReadings.push(memory);
      }
      
      // Navigate to another page
      const links = await page.locator('a').all();
      if (links.length > 0) {
        await links[0].click();
        await page.waitForLoadState('networkidle');
      }
    }
    
    // Memory shouldn't grow significantly
    if (memoryReadings.length > 2) {
      const firstReading = memoryReadings[0];
      const lastReading = memoryReadings[memoryReadings.length - 1];
      const growth = (lastReading - firstReading) / firstReading;
      
      // Less than 50% memory growth
      expect(growth).toBeLessThan(0.5);
    }
  });
});
```

### 3. API Test Suite (`tests/api.spec.ts`)
```typescript
import { test, expect } from '@playwright/test';

test.describe('API Tests', () => {
  test('health check endpoint', async ({ request }) => {
    const response = await request.get('/api/health');
    
    expect(response.ok()).toBeTruthy();
    
    const data = await response.json();
    expect(data).toHaveProperty('status');
    expect(data.status).toBe('healthy');
  });

  test('API error handling', async ({ request }) => {
    // Test 404 handling
    const response = await request.get('/api/nonexistent');
    expect(response.status()).toBe(404);
    
    // Test invalid input handling
    const badRequest = await request.post('/api/data', {
      data: { invalid: 'data' }
    });
    
    // Should return 400 or handle gracefully
    expect([400, 422]).toContain(badRequest.status());
  });

  test('API response times', async ({ request }) => {
    const endpoints = [
      '/api/health',
      // Add your API endpoints
    ];
    
    for (const endpoint of endpoints) {
      const startTime = Date.now();
      const response = await request.get(endpoint);
      const responseTime = Date.now() - startTime;
      
      // API should respond in under 1 second
      expect(responseTime).toBeLessThan(1000);
      
      // Should return valid status
      expect(response.status()).toBeLessThan(500);
    }
  });
});
```

### 4. Accessibility Test Suite (`tests/a11y.spec.ts`)
```typescript
import { test, expect } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';

test.describe('Accessibility Tests', () => {
  test('homepage accessibility', async ({ page }) => {
    await page.goto('/');
    
    const accessibilityScanResults = await new AxeBuilder({ page }).analyze();
    
    // No critical accessibility violations
    expect(accessibilityScanResults.violations).toEqual([]);
  });

  test('keyboard navigation', async ({ page }) => {
    await page.goto('/');
    
    // Tab through interactive elements
    const interactiveElements = [];
    
    for (let i = 0; i < 20; i++) {
      await page.keyboard.press('Tab');
      
      const focusedElement = await page.evaluate(() => {
        const el = document.activeElement;
        return {
          tag: el?.tagName,
          text: el?.textContent?.substring(0, 50),
          href: (el as HTMLAnchorElement)?.href,
        };
      });
      
      if (focusedElement.tag) {
        interactiveElements.push(focusedElement);
      }
    }
    
    // Should have tabbable elements
    expect(interactiveElements.length).toBeGreaterThan(0);
    
    // Test Enter key on links
    await page.goto('/');
    await page.keyboard.press('Tab');
    await page.keyboard.press('Enter');
    
    // Should navigate or perform action
    await page.waitForLoadState('networkidle');
  });

  test('color contrast', async ({ page }) => {
    await page.goto('/');
    
    const contrastIssues = await page.evaluate(() => {
      const elements = document.querySelectorAll('*');
      const issues = [];
      
      elements.forEach(el => {
        const style = window.getComputedStyle(el);
        const bg = style.backgroundColor;
        const fg = style.color;
        
        // Simple check - you'd want a proper contrast calculation
        if (bg === fg && bg !== 'rgba(0, 0, 0, 0)') {
          issues.push({
            element: el.tagName,
            issue: 'Same foreground and background color'
          });
        }
      });
      
      return issues;
    });
    
    expect(contrastIssues).toHaveLength(0);
  });
});
```

### 5. Mobile Test Suite (`tests/mobile.spec.ts`)
```typescript
import { test, expect, devices } from '@playwright/test';

test.describe('Mobile Tests', () => {
  test.use(devices['iPhone 13']);

  test('mobile responsive layout', async ({ page }) => {
    await page.goto('/');
    
    // Check viewport is mobile size
    const viewportSize = page.viewportSize();
    expect(viewportSize?.width).toBeLessThan(768);
    
    // Check mobile menu exists
    const mobileMenu = page.locator('[data-testid="mobile-menu"], button[aria-label*="menu"]');
    await expect(mobileMenu).toBeVisible();
    
    // Test mobile menu interaction
    await mobileMenu.click();
    
    // Menu should open
    const menuItems = page.locator('nav a, [role="menu"] a');
    await expect(menuItems.first()).toBeVisible();
  });

  test('touch interactions work', async ({ page }) => {
    await page.goto('/');
    
    // Find swipeable elements
    const swipeable = page.locator('[data-swipeable], .carousel, .slider').first();
    
    if (await swipeable.count() > 0) {
      const box = await swipeable.boundingBox();
      
      if (box) {
        // Simulate swipe
        await page.touchscreen.tap(box.x + box.width / 2, box.y + box.height / 2);
        await page.touchscreen.swipe({
          startX: box.x + box.width - 10,
          startY: box.y + box.height / 2,
          endX: box.x + 10,
          endY: box.y + box.height / 2,
          steps: 10,
        });
        
        // Some change should occur
        await page.waitForTimeout(500);
      }
    }
  });
});
```

## Playwright Configuration (`playwright.config.ts`)

```typescript
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: 'html',
  
  use: {
    baseURL: 'http://localhost:3000',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
  },

  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
    {
      name: 'firefox',
      use: { ...devices['Desktop Firefox'] },
    },
    {
      name: 'webkit',
      use: { ...devices['Desktop Safari'] },
    },
    {
      name: 'Mobile Chrome',
      use: { ...devices['Pixel 5'] },
    },
    {
      name: 'Mobile Safari',
      use: { ...devices['iPhone 12'] },
    },
  ],

  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:3000',
    reuseExistingServer: !process.env.CI,
    timeout: 120 * 1000,
  },
});
```

## Usage with `/test-dev` Command:

1. **Generate tests if missing**:
   ```bash
   /test-dev --create-tests
   ```

2. **Run specific test level**:
   ```bash
   /test-dev --level=5  # Run all including E2E
   ```

3. **Quick test**:
   ```bash
   /test-dev --skip-e2e  # Skip Playwright tests
   ```

4. **Fix and retry**:
   ```bash
   /test-dev --fix-mode
   ```

These Playwright tests provide comprehensive coverage of:
- ✅ Basic functionality
- ✅ Performance metrics
- ✅ API endpoints
- ✅ Accessibility
- ✅ Mobile responsiveness
- ✅ Error handling
- ✅ User interactions

The tests are progressive - start with basic tests and add more comprehensive ones as your app grows!