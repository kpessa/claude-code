---
date: 2025-08-16
status: Proposed
deciders: [Claude Main Thread via /optimize-models]
consulted: [Anthropic Pricing Documentation]
informed: [All agents]
tags: [#adr, #architecture, #decision, #models, #cost-optimization, #automation]
---

# ADR-002: Automated Model Optimization Update

## Status
Proposed

## Context
Used the `/optimize-models` command to search for latest Claude models and optimize assignments. As of August 2025, Anthropic offers:

### Current Model Tiers:
- **Claude Opus 4.1**: $15/$75 per million tokens - Best for complex reasoning
- **Claude Sonnet 4**: 
  - Standard: $3/$15 per million tokens (up to 200K tokens)
  - Extended: $6/$22.50 per million tokens (over 200K tokens)
  - 1M token context window available

No Haiku model currently available, Sonnet 4 is the most economical option.

## Decision Drivers
- Minimize costs for high-volume research tasks
- Maintain quality for critical reasoning
- Avoid extended pricing tier (>200K tokens) for Sonnet
- Leverage 1M context window when beneficial
- Automate model updates as new models release

## Considered Options
1. **Keep current configuration**: Opus 4.1 for critical, Sonnet 4 for research
2. **All Sonnet 4**: Use Sonnet for everything to minimize costs
3. **Optimized split**: Sonnet 4 for research (staying under 200K), Opus 4.1 for critical

## Decision Outcome
Chosen option: **"Optimized split"** - Continue using Sonnet 4 for research tasks while ensuring prompts stay under 200K tokens to avoid higher pricing tier.

### Updated Model Assignments

```json
{
  "model": "claude-opus-4-1-20250805",
  "agentModels": {
    "comment": "Research agents use Sonnet 4 (under 200K tokens)",
    "*-researcher": "claude-sonnet-4-20250522",
    "general-researcher": "claude-sonnet-4-20250522",
    "knowledge-curator": "claude-sonnet-4-20250522",
    "codebase-analyst": "claude-sonnet-4-20250522",
    
    "comment2": "Critical reasoning agents use Opus 4.1",
    "knowledge-synthesizer": "claude-opus-4-1-20250805",
    "code-reviewer": "claude-opus-4-1-20250805",
    "debug-troubleshooter": "claude-opus-4-1-20250805",
    "refactor-specialist": "claude-opus-4-1-20250805",
    
    "comment3": "Development agents use Sonnet 4",
    "testing-qa": "claude-sonnet-4-20250522",
    "deployment-cicd": "claude-sonnet-4-20250522",
    "state-persistence-sync": "claude-sonnet-4-20250522",
    "performance-optimizer": "claude-sonnet-4-20250522"
  }
}
```

### Positive Consequences
- **Current configuration already optimal** for available models
- **80% cost savings** maintained on research tasks
- **Avoiding extended pricing** by keeping research under 200K tokens
- **1M context window** available when needed for large codebases

### Negative Consequences
- **No cheaper tier available** (Haiku not currently offered)
- **Risk of hitting extended pricing** if prompts exceed 200K tokens
- **Need monitoring** to ensure research stays under threshold

## Implementation Recommendations

### Token Management Strategy
1. Monitor research agent token usage
2. Split large research tasks if approaching 200K
3. Use context windowing for large codebases
4. Consider prompt caching for repeated patterns (90% savings)

### Future Optimizations
- Watch for Haiku model release for research tasks
- Consider batch processing for 50% additional savings
- Implement prompt caching for common patterns
- Monitor for new model releases quarterly

## Cost Analysis

### Current Costs (Per 100K tokens):
- **Research (Sonnet 4)**: $0.30 input + $1.50 output = $1.80
- **Critical (Opus 4.1)**: $1.50 input + $7.50 output = $9.00

### If Haiku becomes available (~$0.25/$1.25):
- **Research (Haiku)**: $0.025 input + $0.125 output = $0.15
- **Potential savings**: 91.7% on research tasks

## Validation Metrics
- Track token usage per agent type
- Monitor for extended pricing triggers
- Measure response quality consistency
- Calculate actual vs projected costs

## Automation Success
The `/optimize-models` command successfully:
- ✅ Retrieved latest model information
- ✅ Analyzed pricing tiers
- ✅ Validated current configuration
- ✅ Identified optimization opportunities
- ✅ Created documentation

## Related Decisions
- [[ADR-001-model-selection-strategy]] - Initial model selection
- [[Research-First-Methodology]] - High-volume research approach

## Notes
- Current configuration is already optimal for available models
- Command will be more valuable when new models release
- Recommend running quarterly or when Anthropic announces new models
- Consider setting up alerts for new model announcements

---

*Analysis performed: 2025-08-16*  
*Next review: When new models announced*  
*Command used: /optimize-models*