# Refactoring Research

This directory contains research and analysis from the refactor-researcher agent about code quality, technical debt, and refactoring strategies.

## Directory Structure

- `debt-inventory-[date].md` - Cataloged technical debt with severity scores
- `complexity-analysis-[date].md` - Code complexity metrics and hotspots
- `patterns-[component].md` - Recurring patterns and anti-patterns by component
- `strategies-[feature].md` - Specific refactoring strategies for features
- `quick-wins-[date].md` - Low-effort, high-impact improvements

## How It Works

1. **Research Phase**: The refactor-researcher agent analyzes code without modifying it
2. **Documentation**: Findings are documented here with specific file:line references
3. **Implementation**: Main thread applies recommendations based on research
4. **Validation**: Type-check hooks validate the changes automatically

## Integration with Type-Check Hook

When the type-check-hook.sh detects TypeScript or ESLint errors:
- Refactor-researcher analyzes root causes and patterns
- Documents systemic issues vs one-off problems
- Provides context and best practice solutions
- Main thread implements fixes with full understanding

## Cost Benefits

Using research-only approach:
- 80% cost reduction (Haiku vs Opus model)
- Better integration with existing hooks
- Knowledge persistence for future reference
- Avoids conflicts between agent edits and hook corrections