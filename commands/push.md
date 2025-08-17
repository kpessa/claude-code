---
description: Push current branch to remote repository
---

# Push to Remote

Push your current branch to the remote repository with automatic upstream handling.

## Usage:
- `/push` - Push current branch
- `/push --force` - Force push (use with caution)
- `/push --pr` - Push and create pull request

## Workflow:

1. **Check current branch and remote:**
   ```bash
   git branch --show-current
   git remote -v
   ```

2. **Attempt push:**
   ```bash
   git push
   ```

3. **If no upstream, set it:**
   ```bash
   git push -u origin $(git branch --show-current)
   ```

4. **Handle common scenarios:**
   - If behind remote: Suggest `git pull --rebase`
   - If diverged: Explain options (rebase vs merge)
   - If force needed: Require explicit `--force` flag

## Options:

### Create PR After Push:
If `--pr` flag is provided and `gh` CLI is available:
```bash
gh pr create --fill
```

### Force Push:
If `--force` flag is provided:
```bash
git push --force-with-lease
```
(Uses `--force-with-lease` for safety)

## Success Output:
```
✅ Pushed to: origin/feature-branch
🔗 Remote: https://github.com/user/repo
📊 Commits pushed: 3
```

$ARGUMENTS