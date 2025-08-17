---
description: Search for latest Claude models and optimize agent assignments for cost and performance
---

# Optimize Model Assignments

Search for the latest Claude models from Anthropic and update the agent system to use the optimal model for each agent type, balancing cost and performance.

## Instructions:

1. **Search for latest models**: 
   - Search the web for "Claude AI models latest pricing Anthropic" to find current models
   - Look for model names, versions, release dates, and pricing (per million tokens)
   - Identify the tier of each model (Opus/Sonnet/Haiku equivalent)

2. **Analyze and categorize models**:
   - Identify the most expensive/capable model (Opus-tier)
   - Identify the balanced model (Sonnet-tier)  
   - Identify the economical model (Haiku-tier or lowest Sonnet)
   - Note the pricing for each

3. **Optimize assignments** based on these rules:
   - **Research agents** (*-researcher, knowledge-curator, codebase-analyst): Use economical model
   - **Critical agents** (knowledge-synthesizer, code-reviewer, debug-troubleshooter, refactor-specialist): Use most capable model
   - **Development agents** (testing-qa, deployment-cicd, state-persistence-sync, performance-optimizer): Use balanced model
   - **Main thread**: Use most capable model

4. **Update configuration**:
   - Update `/Users/kpessa/.claude/settings.json` with the new model assignments
   - Include comments with pricing information
   - Ensure model names follow the correct format (e.g., claude-opus-4-1-20250805)

5. **Document the decision**:
   - Create an ADR in `_knowledge/04-Decisions/` explaining the model updates
   - Include cost analysis showing expected savings
   - Document the rationale for each assignment

6. **Report results**:
   - Show which models were updated
   - Calculate expected cost impact
   - Highlight performance implications

## Example assignments pattern:
```json
{
  "model": "[most-capable-model]",
  "agentModels": {
    "*-researcher": "[economical-model]",
    "knowledge-curator": "[economical-model]",
    "knowledge-synthesizer": "[most-capable-model]",
    "testing-qa": "[balanced-model]"
  }
}
```

Please search for the latest models and optimize the configuration now.

$ARGUMENTS