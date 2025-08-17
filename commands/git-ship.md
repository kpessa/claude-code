---
description: Commit all changes with a meaningful message and push to remote repository
---

# Git Ship - Commit and Push

Quickly commit all changes with an auto-generated or custom commit message and push to the remote repository.

## What this command does:

1. **Checks git status** - Shows what will be committed
2. **Auto-generates commit message** - Based on the changes made
3. **Commits all changes** - Stages and commits everything
4. **Pushes to remote** - Pushes to the current branch's remote

## Instructions:

### Step 1: Check Current Status
Run these commands in parallel to understand the current state:
- `git status` - See all changed files
- `git diff --stat` - Summary of changes
- `git branch --show-current` - Current branch name
- `git remote -v` - Verify remote exists

### Step 2: Analyze Changes
Based on the git diff and status:
- Identify the main type of change (feature, fix, refactor, docs, style, test, chore)
- Summarize what was modified
- Check for any sensitive information that shouldn't be committed

### Step 3: Generate Commit Message
Create a conventional commit message following this format:
```
<type>(<scope>): <subject>

<body>

<footer>
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `refactor`: Code refactoring
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `test`: Test changes
- `chore`: Maintenance tasks
- `perf`: Performance improvements

### Step 4: Stage and Commit
```bash
# Stage all changes
git add -A

# Commit with generated message
git commit -m "<generated message>"
```

### Step 5: Push to Remote
```bash
# Push to current branch
git push

# If branch has no upstream, set it:
git push -u origin <branch-name>
```

### Step 6: Confirm Success
Show the user:
- Commit hash
- Files changed count
- Branch pushed to
- Remote URL

## Options:

If arguments are provided, use them as the commit message:
- `/git-ship` - Auto-generate message
- `/git-ship fix: resolved navigation bug` - Use provided message
- `/git-ship --amend` - Amend previous commit and force push

## Safety Checks:

Before committing:
1. ⚠️ Check for sensitive files (.env, secrets, API keys)
2. ⚠️ Warn if committing node_modules or large files
3. ⚠️ Confirm if on main/master branch
4. ⚠️ Check if there are uncommitted changes in submodules

## Example Output:

```
🔍 Analyzing changes...
  - 5 files changed
  - Main changes: Added UI framework analysis command
  
📝 Commit message:
  "feat(commands): add analyze-ui-frameworks slash command"

✅ Committed: abc1234
🚀 Pushed to: origin/feature-branch
🔗 Remote: https://github.com/user/repo

Successfully shipped your changes! 🎉
```

## Error Handling:

If push fails:
1. Check if you need to pull first: `git pull --rebase`
2. Resolve any conflicts
3. Retry push
4. If still failing, provide detailed error message

## Additional Features:

### Auto-PR Creation (if gh CLI available):
After successful push, optionally:
```bash
gh pr create --title "<commit message>" --body "Auto-generated PR"
```

### Commit Message Enhancement:
- Add emoji based on type (🎉 feat, 🐛 fix, ♻️ refactor)
- Include issue numbers if found in branch name
- Add co-authors if pair programming

$ARGUMENTS