---
description: Comprehensive project audit using specialized research agents - analyzes all aspects of codebase and updates knowledge base
tools: [Task, TodoWrite, Read, Glob, LS]
---

# Comprehensive Project Audit: Multi-Agent Analysis

Orchestrating specialized research agents to perform deep codebase analysis and build knowledge base...

## Overview
This audit leverages multiple specialized research agents running in parallel to analyze different aspects of your codebase. Each agent writes findings to the knowledge base for persistent learning.

## Phase 1: Initialize Audit Tracking

Create a todo list to track the audit phases:
1. Launch parallel research agents for initial analysis
2. Perform deep architecture and data flow analysis
3. Synthesize findings across all agents
4. Update knowledge base with comprehensive review

## Phase 2: Parallel Research Tasks (Cost-Optimized with Haiku)

Launch the following research agents in parallel for comprehensive analysis:

### Testing & Quality Analysis
Use the **testing-researcher** agent to:
- Analyze test suite health and coverage
- Identify missing test scenarios
- Evaluate test framework usage and patterns
- Document findings in `_knowledge/01-Research/Testing/AUDIT-{date}.md`

### Technical Debt Assessment
Use the **refactor-researcher** agent to:
- Identify code duplication and complexity
- Find outdated patterns and deprecated code
- Analyze TypeScript/build issues
- Document findings in `_knowledge/01-Research/Refactoring/AUDIT-{date}.md`

### Performance Analysis
Use the **performance-researcher** agent to:
- Identify performance bottlenecks
- Analyze bundle sizes and load times
- Find inefficient algorithms and data structures
- Document findings in `_knowledge/01-Research/Performance/AUDIT-{date}.md`

### Security Audit
Use the **security-researcher** agent to:
- Check for security vulnerabilities
- Review authentication and authorization patterns
- Identify exposed secrets or unsafe operations
- Document findings in `_knowledge/01-Research/Security/AUDIT-{date}.md`

### UI/UX Patterns Review
Use the **ui-ux-researcher** agent to:
- Analyze component organization and reusability
- Review accessibility compliance
- Identify UI consistency issues
- Document findings in `_knowledge/01-Research/UI-UX/AUDIT-{date}.md`

## Phase 3: Deep Architecture Analysis

### Codebase Structure Analysis
Use the **codebase-analyst** agent to:
- Map overall architecture and dependencies
- Identify architectural patterns and anti-patterns
- Analyze module coupling and cohesion
- Create architecture diagrams and documentation
- Write comprehensive analysis to `_knowledge/02-Architecture/AUDIT-{date}.md`

### Data Flow Analysis
Use the **data-flow-researcher** agent to:
- Map data flow through the application
- Identify state management patterns
- Analyze API integration points
- Document data architecture in `_knowledge/03-Data-Flow/AUDIT-{date}.md`

## Phase 4: Framework-Specific Analysis (if applicable)

Based on the project technology stack, launch relevant framework researchers:

- **react-researcher** for React projects
- **svelte-researcher** for Svelte projects
- **nextjs-researcher** for Next.js projects
- **firebase-researcher** for Firebase integration
- **database-researcher** for database architecture

Each writes findings to their respective knowledge directories.

## Phase 5: Synthesis and Prioritization

Use the **knowledge-synthesizer** agent to:
- Combine findings from all research agents
- Identify cross-cutting concerns
- Prioritize issues by impact on development velocity
- Generate executive summary
- Create `_knowledge/06-Reviews/COMPREHENSIVE-AUDIT-{date}.md`

## Phase 6: Knowledge Base Organization

Use the **knowledge-curator** agent to:
- Organize all research findings
- Update index and navigation
- Create knowledge graphs showing relationships
- Identify gaps in research coverage
- Update `_knowledge/00-Overview/CURRENT_STATE.md`
- Generate `_knowledge/06-Reviews/RAPID_PROTOTYPING_ROADMAP.md`

## Phase 7: Update Project Context (CLAUDE.MD)

Use the **knowledge-synthesizer** agent to:
- Read the current CLAUDE.MD file (or create if it doesn't exist)
- Analyze all audit findings from phases 1-6
- Create backup directory `_knowledge/07-Backups/` if it doesn't exist
- Save backup as `_knowledge/07-Backups/CLAUDE.MD-{yyyy-mm-dd-HH-mm}.md`
- Update CLAUDE.MD with new audit-derived sections while preserving user preferences
- Keep last 10 backups (remove older ones to prevent accumulation)

### Sections to Add/Update in CLAUDE.MD:

#### Project Health Status
- Last audit date and overall health score
- Build, test, and deployment status
- Test coverage percentage
- Performance metrics (bundle size, load time)
- Critical issue count by priority

#### Known Issues & Technical Debt
- **P0 - Critical**: Blocking issues with file locations
- **P1 - High Priority**: Significant velocity impacts
- **P2 - Medium**: Quality improvements needed
- Include specific file paths and line numbers for each issue

#### Discovered Project Patterns
- **Effective Patterns**: What's working well in the codebase
- **Anti-Patterns**: What to avoid based on audit findings
- **Recommended Refactors**: Specific files exceeding complexity thresholds

#### Project-Specific Commands
- Actual test, lint, build commands found in package.json
- CI/CD commands and deployment scripts
- Development workflow commands

#### Tech Stack Updates
- Discovered dependencies not previously documented
- Framework versions in use
- Database and API integrations found

### Update Strategy:
1. Preserve all existing user preferences and custom sections
2. Add audit sections at the end of the file
3. Use clear markdown formatting with timestamps
4. Include actionable information for future development
5. Ensure all critical issues are prominently documented

### Example Update Format:
```markdown
<!-- AUDIT SECTION - Last Updated: {date} -->
## Project Health Status
Generated by comprehensive audit on {date}

### Metrics
- **Build Status**: ✅ Passing / ❌ Failing
- **Test Coverage**: {percentage}%
- **Bundle Size**: {size}KB
- **Critical Issues**: {P0_count} P0, {P1_count} P1

### Critical Issues Requiring Immediate Attention
#### P0 - Blocking Development
1. **{Issue Title}** 
   - Location: `path/to/file.ts:line`
   - Impact: {description}
   - Recommended Fix: {action}

[Additional sections...]
```

This ensures that:
- Future Claude Code sessions are aware of project health
- Critical issues aren't forgotten between sessions
- Project-specific patterns guide development
- Technical debt is tracked and visible

## Output Format

The final audit report will include:

### Priority Matrix
- **P0 - Critical** (Blocking development)
  - Issues preventing builds or deployments
  - Security vulnerabilities
  - Major performance problems

- **P1 - High** (Significant velocity impact)
  - Technical debt slowing development
  - Missing critical tests
  - Architecture issues

- **P2 - Medium** (Quality improvements)
  - Code organization issues
  - Minor performance optimizations
  - UI/UX inconsistencies

- **P3 - Low** (Nice to have)
  - Documentation gaps
  - Style improvements
  - Minor refactoring opportunities

### Each Finding Includes:
- Problem description with specific examples
- Impact on development velocity (quantified when possible)
- Estimated remediation effort (hours/days)
- Specific file locations and line numbers
- Recommended solution with implementation steps
- Links to relevant research in knowledge base

## Benefits of Agent-Based Audit

1. **Cost Efficiency**: 95% cost reduction using Haiku models for research
2. **Parallel Execution**: Multiple agents work simultaneously
3. **Persistent Knowledge**: Findings stored for future reference
4. **Specialized Expertise**: Each agent focuses on their domain
5. **Comprehensive Coverage**: No aspect of the codebase is overlooked

## Automation Recommendations

After audit completion, consider:
- Setting up weekly health checks with `/health-check`
- Creating git hooks for pre-commit validation
- Implementing CI/CD pipeline checks
- Scheduling regular audit runs (monthly/quarterly)

## Note on Execution

The main thread will:
1. Launch agents with specific, focused prompts
2. Monitor agent progress through todo list
3. Collect and review findings as they complete
4. Present consolidated results to user
5. Suggest immediate action items based on P0/P1 findings

This agent-orchestrated approach ensures thorough analysis while building a comprehensive knowledge base for future development acceleration.