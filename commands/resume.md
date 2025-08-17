---
description: Comprehensive project context recovery - understand what you've been working on and what to do next
---

# Resume - Context Recovery & Next Steps

Instantly understand where you left off, what you've accomplished, and what to focus on next. Perfect for returning to a project after a few days away.

## Usage:
- `/resume` - Analyze last 7 days (default)
- `/resume 30` - Analyze last 30 days
- `/resume today` - Today's work only
- `/resume week` - This week's progress

## What This Command Does:

### 1. 📊 Recent Activity Analysis
Gather comprehensive context about your recent work:
- Last 10-20 git commits with messages
- Recently modified files and directories
- Knowledge base updates and research
- Active branches and their status
- Uncommitted changes waiting

### 2. 🔍 Current State Assessment
Understand exactly where the project stands:
- Current phase from Implementation-Phases.md
- Progress on strategic goals from context.md
- Active development areas
- Pending decisions and blockers
- Knowledge gaps identified

### 3. 🎯 Generate Actionable Insights
Get clear direction on what to do next:
- Priority tasks based on project phase
- Quick wins (< 30 minutes)
- Research needed before implementing
- Decisions requiring attention
- Patterns to document

### 4. 💾 Knowledge Base Update
Keep your system current:
- Create daily note in `_knowledge/09-Daily/resume-YYYY-MM-DD.md`
- Update context.md with current status
- Log insights for future pattern analysis
- Track progress metrics

## Workflow Instructions:

### Phase 1: Gather Context
Run these commands in parallel to collect information:

```bash
# Git activity
git log --oneline -20
git status --short
git branch -a
find . -type f -mtime -7 -name "*.md" | head -20  # Recent markdown files

# Knowledge base status
ls -la _knowledge/09-Daily/
ls -la _knowledge/01-Research/
grep -r "TODO\|FIXME\|XXX" --include="*.md" . | head -10
```

### Phase 2: Analyze and Synthesize

1. **Read key context files:**
   - `_knowledge/context.md` - Current vision and goals
   - `_knowledge/02-Architecture/Implementation-Phases.md` - Phase status
   - `_knowledge/00-Index/Knowledge-Map.md` - Knowledge structure
   - Recent files in `_knowledge/09-Daily/` if any

2. **Identify patterns:**
   - What type of work dominates? (research, implementation, documentation)
   - What areas are getting attention?
   - What's being neglected?
   - Are we following the research-first methodology?

3. **Assess progress:**
   - Compare current state to phase goals
   - Calculate completion percentages
   - Identify blockers or deviations

### Phase 3: Generate Report

Create a comprehensive report with these sections:

## 🎯 Executive Summary
```markdown
**Last Active**: [X days ago]
**Current Focus**: [Main area of work]
**Project Phase**: [Phase 2: Knowledge Synthesis - 15% complete]
**Key Achievement**: [Most significant recent accomplishment]
**Next Priority**: [Single most important next action]
```

## 📈 Recent Achievements (Last [N] Days)
- List 5-10 significant accomplishments
- Include metrics where possible (e.g., "Created 18 researcher agents")
- Highlight completed goals from context.md

## 🚀 Suggested Next Actions
Based on project phase and recent work:

**Priority 1 - Must Do:**
- [ ] [Critical task for phase progression]

**Priority 2 - Should Do:**
- [ ] [Important but not blocking]
- [ ] [Another important task]

**Priority 3 - Could Do:**
- [ ] [Nice to have]
- [ ] [Future consideration]

## ⚡ Quick Wins (< 30 minutes each)
- [ ] Document one pattern you use frequently
- [ ] Create ADR for recent decision
- [ ] Update context.md with current status
- [ ] Run `/optimize-models` to check for updates
- [ ] Research one missing pattern

## 🔍 Areas Needing Attention
Identify gaps based on targets:
- **Pattern Library**: 1/30 patterns documented (need 29 more)
- **ADRs**: 3/10 created (need 7 more)
- **Research Coverage**: Missing [specific areas]
- **Knowledge Synthesis**: Not yet activated

## 📊 Metrics Dashboard
```
Phase 2 Progress: ████░░░░░░ 15%
Agents Deployed:  ████████░░ 85%
Knowledge Docs:   ██░░░░░░░░ 20%
Pattern Library:  █░░░░░░░░░ 3%
ADRs Created:     ███░░░░░░░ 30%
```

## 🔄 Workflow Recommendations
Based on your recent patterns:
- If mostly researching → Time to synthesize and create patterns
- If mostly implementing → Step back and document learnings
- If mostly configuring → Focus on using the system for real work

## 📝 Session Notes
[Any specific observations about the current state, blockers, or opportunities]

### Phase 4: Update Knowledge Base

1. **Create daily note**: `_knowledge/09-Daily/resume-YYYY-MM-DD.md`
   Include:
   - Summary of findings
   - Decisions made
   - Intentions for next session
   - Questions to research

2. **Update context.md**:
   - Last reviewed date
   - Current phase status
   - Updated metrics

3. **Set intentions**:
   - What will you accomplish today?
   - What research is needed?
   - What decisions need to be made?

## Special Considerations:

### For Long Gaps (> 7 days):
- Do deeper historical analysis
- Check for dependency updates
- Review any external changes
- Verify all systems still working

### For Project Switching:
- Note which project you're resuming
- Check for context conflicts
- Review project-specific goals
- Load project-specific knowledge

### For Team Collaboration:
- Check for others' commits
- Review PRs or issues
- Sync knowledge bases
- Coordinate on priorities

## Example Output:

```markdown
# Resume Report - 2025-08-16

## 🎯 Executive Summary
**Last Active**: 2 days ago
**Current Focus**: Knowledge-first system implementation
**Project Phase**: Phase 2: Knowledge Synthesis - 15% complete
**Key Achievement**: Implemented 73% cost reduction with Haiku 3.5
**Next Priority**: Deploy researchers to build pattern library

## 📈 Recent Achievements (Last 7 Days)
✅ Created 18 specialized researcher agents
✅ Implemented model optimization (Haiku 3.5)
✅ Built 6 slash commands for workflow automation
✅ Established knowledge vault with Obsidian
✅ Created UI framework analysis system

## 🚀 Suggested Next Actions

**Priority 1 - Must Do:**
- [ ] Deploy 3 researchers to document patterns

**Priority 2 - Should Do:**
- [ ] Create ADR for agent architecture
- [ ] Run knowledge-synthesizer on existing research

**Priority 3 - Could Do:**
- [ ] Test shadcn/ui recommendation in a project
- [ ] Research testing patterns

## ⚡ Quick Wins (< 30 minutes each)
- [ ] Document your most-used React pattern
- [ ] Create ADR-004 for UI framework decision
- [ ] Run `/optimize-models` (last run: 2 days ago)

## 🔍 Areas Needing Attention
- **Pattern Library**: 1/30 patterns (need 29 more)
- **ADRs**: 3/10 created (need 7 more)
- **Daily Notes**: Not being used consistently
- **Knowledge Synthesis**: Agent not yet deployed

Ready to continue? Start with the Priority 1 task! 🚀
```

$ARGUMENTS