# Centralized Agent Strategy

## Overview
All agents and commands are now centralized at the user level (`~/.claude/`) rather than scattered across individual projects. This provides consistency, easier maintenance, and shared knowledge across all projects.

## Directory Structure

```
~/.claude/
├── agents/                 # All agent configurations
│   ├── archived/          # Deprecated developer agents
│   └── *.md              # Active agents (mostly researchers)
├── commands/              # Global slash commands
│   ├── pr-review.md      # GitHub PR review
│   ├── health-check.md   # Quick project health check
│   ├── audit.md          # Comprehensive codebase audit
│   └── *.md              # Other commands
├── _knowledge/           # Centralized knowledge base
│   └── 01-Research/      # Research findings from agents
└── settings.json         # Global settings and model assignments
```

## Benefits of Centralization

### 1. **Consistency**
- Same agents available in all projects
- Uniform behavior across codebases
- Single source of truth for configurations

### 2. **Knowledge Sharing**
- Research findings available globally
- Patterns learned in one project benefit all
- Cumulative knowledge base growth

### 3. **Maintenance**
- Update agents in one place
- No duplicate configurations
- Easier version control

### 4. **Cost Optimization**
- Centralized model assignments
- Research agents use cheaper models (Haiku)
- Critical agents use powerful models (Opus)

## Agent Categories

### Research Agents (Haiku Model - 95% cost savings)
- `*-researcher` - Domain-specific research
- `knowledge-curator` - Organizes findings
- `codebase-analyst` - Analyzes code structure

### Critical Agents (Opus Model)
- `knowledge-synthesizer` - Complex reasoning
- `code-reviewer` - Code quality checks
- `debug-troubleshooter` - Problem solving

### Development Agents (Haiku Model)
- `testing-qa` - Test implementation
- `deployment-cicd` - Deployment tasks
- `performance-optimizer` - Performance tuning

## Command Categories

### Code Review
- `/pr-review` - Review GitHub pull requests
- `/code-review` - Review recent changes

### Project Health
- `/health-check` - Quick velocity check
- `/audit` - Comprehensive analysis
- `/test` - Run test suites

### Git Workflow
- `/commit` - Smart commit creation
- `/push` - Push changes
- `/git-ship` - Full deployment flow

### Optimization
- `/optimize-models` - Update agent models
- `/resume` - Restore project context

## Best Practices

### 1. **Use Researchers First**
- Cheaper and builds knowledge
- Main thread implements based on research
- Preserves context and control

### 2. **Leverage Knowledge Base**
- Check `_knowledge/` for existing research
- Agents write findings for reuse
- Build on previous discoveries

### 3. **Project-Specific Needs**
- Use CLAUDE.md for project preferences
- Override commands only when necessary
- Keep overrides minimal and documented

### 4. **Regular Maintenance**
- Review archived agents quarterly
- Update model assignments with new releases
- Consolidate duplicate research

## Migration from Project-Based

If you have project-specific agents/commands:

1. **Evaluate Uniqueness**
   - Is it truly project-specific?
   - Could other projects benefit?

2. **Generalize if Possible**
   - Make it work across projects
   - Use parameters for flexibility

3. **Move to User Level**
   - Copy to `~/.claude/agents/` or `commands/`
   - Remove from project

4. **Document in CLAUDE.md**
   - Note any project-specific usage
   - Explain parameters needed

## Model Cost Comparison

| Model | Input | Output | Use Case |
|-------|-------|--------|----------|
| Haiku 3.5 | $0.80/M | $4/M | Research, routine tasks |
| Opus 4.1 | $15/M | $75/M | Critical reasoning |

**Savings**: Using researchers saves 95% on costs while building persistent knowledge.

## Future Enhancements

- [ ] Agent dependency management
- [ ] Automatic agent selection based on task
- [ ] Knowledge graph visualization
- [ ] Cross-project pattern detection
- [ ] Automated agent performance metrics

---

*Last Updated: 2025-08-17*
*Strategy: Centralized user-level agents with research-first approach*