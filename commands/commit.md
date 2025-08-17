---
description: Quick commit and push with smart message generation
---

# Quick Commit & Push

Fast git commit and push with intelligent commit message generation.

## Usage:
- `/commit` - Auto-generate message and push
- `/commit your message here` - Use your message and push
- `/commit --no-push` - Commit only, don't push

## Workflow:

1. **Check what's changed:**
   ```bash
   git status --short
   git diff --stat
   ```

2. **Generate commit message:**
   - If no message provided, analyze changes and create one:
     - Look at file types changed
     - Identify the primary change (feat/fix/docs/style/refactor)
     - Create concise, descriptive message

3. **Stage and commit:**
   ```bash
   git add -A
   git commit -m "[generated or provided message]"
   ```

4. **Push to remote:**
   ```bash
   git push || git push -u origin $(git branch --show-current)
   ```

## Smart Message Generation:

Analyze the changes to determine commit type:

- **New files added** → `feat: add [what was added]`
- **Bug fixes** → `fix: resolve [what was fixed]`
- **Documentation** → `docs: update [what docs]`
- **Refactoring** → `refactor: improve [what was refactored]`
- **Tests** → `test: add/update [test description]`
- **Configs/settings** → `chore: configure [what was configured]`

## Examples:

```bash
# Auto-generate message
/commit
# Output: "feat: add UI framework analysis command"

# Custom message
/commit fix: resolve navigation menu z-index issue

# Commit without pushing
/commit --no-push refactor: extract shared utilities
```

## Quick Checks:
- ⚠️ Warn if .env or secrets detected
- ⚠️ Confirm if on main/master branch
- ✅ Show files being committed
- ✅ Display commit hash after success

$ARGUMENTS