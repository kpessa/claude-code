---
description: Automatically update all agent models to the latest available, optimizing for cost, quality, and efficiency
---

# 🚀 Update Models to Latest Available

This command automatically searches for the latest Claude models, analyzes their capabilities and pricing, then updates your agent configuration to use the optimal model for each task type.

## What this command does:

1. **🔍 Searches for latest models** - Queries Anthropic's website for current Claude models
2. **💰 Analyzes pricing** - Compares costs per million tokens
3. **⚡ Evaluates capabilities** - Identifies which tier each model belongs to
4. **🎯 Optimizes assignments** - Maps the right model to the right agent type
5. **⚙️ Updates configuration** - Modifies settings.json automatically
6. **📝 Documents decision** - Creates an ADR explaining the changes
7. **📊 Reports impact** - Shows expected cost savings and performance changes

## Optimization Strategy:

### Agent Categories and Model Selection:

**🔬 Research Agents** (High volume, structured tasks)
- Uses: Cheapest capable model (typically Haiku or lower Sonnet tier)
- Agents: All `*-researcher`, `knowledge-curator`, `codebase-analyst`
- Rationale: High token volume but structured work

**🧠 Critical Reasoning** (Complex decisions, architectural work)
- Uses: Most capable model (Opus tier)
- Agents: `knowledge-synthesizer`, `code-reviewer`, `debug-troubleshooter`, `refactor-specialist`
- Rationale: Need advanced reasoning capabilities

**⚙️ Development Tasks** (Balanced needs)
- Uses: Mid-tier model (Sonnet tier)
- Agents: `testing-qa`, `deployment-cicd`, `state-persistence-sync`, `performance-optimizer`
- Rationale: Balance of capability and cost

**🎭 Main Thread** (User interaction, orchestration)
- Uses: Most capable model (Opus tier)
- Rationale: Complex orchestration and user interaction

## Execution Steps:

1. Search for "Claude models pricing" on Anthropic's website
2. Extract model information:
   - Model names and versions
   - Pricing (input/output per million tokens)
   - Capabilities and benchmarks
   - Release dates

3. Categorize models by tier:
   - Opus-class: Best reasoning, highest cost
   - Sonnet-class: Balanced performance and cost
   - Haiku-class: Fast and economical

4. Apply optimization rules:
   ```
   if (agent.type === 'researcher') {
     assign(cheapest_capable_model);
   } else if (agent.type === 'critical') {
     assign(best_reasoning_model);
   } else if (agent.type === 'development') {
     assign(balanced_model);
   }
   ```

5. Update `/Users/kpessa/.claude/settings.json`:
   - Update main model
   - Update agentModels mapping
   - Add pricing comments
   - Preserve existing structure

6. Create ADR at `_knowledge/04-Decisions/ADR-[NUM]-model-update-[DATE].md`:
   - Document model changes
   - Include cost analysis
   - Explain optimization rationale
   - Track version history

7. Generate report showing:
   - Models updated
   - Cost impact (before/after)
   - Performance implications
   - Agents affected

## Command Options:

- **Default**: `/update-models` - Updates all models automatically
- **Preview**: `/update-models preview` - Shows what would change without applying
- **Force**: `/update-models force` - Updates even if models haven't changed
- **Rollback**: `/update-models rollback` - Reverts to previous configuration

## Safety Features:

- Creates backup of current settings before changes
- Validates model names against known patterns
- Checks for breaking changes
- Preserves custom configurations
- Documents all changes in ADR

## Expected Output Example:

```
🔍 Searching for latest Claude models...
✅ Found 3 model tiers available:
   - Claude Opus 5 ($20/$100 per M tokens) - Best reasoning
   - Claude Sonnet 4.5 ($4/$20 per M tokens) - Balanced
   - Claude Haiku 3 ($0.25/$1.25 per M tokens) - Fast & economical

📊 Current vs Optimized Configuration:
   Research agents: Sonnet 4 → Haiku 3 (87.5% cost reduction)
   Critical agents: Opus 4.1 → Opus 5 (better performance, 33% cost increase)
   Development: Sonnet 4 → Sonnet 4.5 (33% cost increase, 40% faster)

⚙️ Updating settings.json...
📝 Creating ADR-003-model-update-2025-08-16.md...

✅ Model update complete!
💰 Expected monthly savings: $450 (65% reduction in research costs)
⚡ Performance impact: +25% speed on research, +15% quality on critical tasks
```

## Troubleshooting:

If the command fails:
1. Check internet connection for web search
2. Verify settings.json exists and is valid JSON
3. Ensure _knowledge/04-Decisions/ directory exists
4. Check that you have necessary permissions

## Notes:

- This command uses web search to get real-time model information
- Model assignments are based on empirical cost/performance trade-offs
- The command learns from previous optimizations via ADRs
- Custom model assignments in settings.json are preserved unless explicitly updated

$ARGUMENTS