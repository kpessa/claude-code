---
date: 2025-08-16
status: Accepted
deciders: [User, Claude Main Thread]
consulted: [Anthropic Documentation]
informed: [All agents]
tags: [#adr, #architecture, #decision, #models, #cost-optimization]
---

# ADR-001: Model Selection Strategy for Agent System

## Status
Accepted

## Context
The Claude agent system consists of 31 agents with varying computational needs. Using the most powerful model (Opus 4.1) for all agents would be expensive and inefficient. Different agents have different requirements:
- Research agents primarily read, analyze, and write documentation (high volume, structured tasks)
- Critical reasoning agents make architectural decisions and complex judgments
- Development agents perform routine code modifications

As of August 2025, Anthropic offers:
- **Claude Opus 4.1**: $15/$75 per million tokens (input/output) - Best for complex reasoning
- **Claude Sonnet 4**: $3/$15 per million tokens - Excellent balance of performance and cost

## Decision Drivers
- **Cost optimization**: Research generates high token volume
- **Performance requirements**: Critical decisions need best reasoning
- **Response time**: Faster responses for routine tasks
- **Quality maintenance**: No compromise on output quality
- **Scalability**: Enable parallel research within budget

## Considered Options
1. **All Opus**: Use Opus 4.1 for everything
2. **All Sonnet**: Use Sonnet 4 for everything
3. **Hybrid approach**: Opus for critical tasks, Sonnet for routine work

## Decision Outcome
Chosen option: **"Hybrid approach"**, because it optimizes cost while maintaining quality where it matters most.

### Model Assignments

#### Sonnet 4 Agents (Cost-Efficient)
**Research Agents** - Documentation and pattern research:
- All `*-researcher` agents (18 total)
- `knowledge-curator` - Organization tasks
- `codebase-analyst` - Structured analysis

**Routine Development** - Standard implementations:
- `testing-qa` - Test implementation
- `deployment-cicd` - Deployment configuration
- `state-persistence-sync` - State management
- `performance-optimizer` - Optimization tasks

#### Opus 4.1 Agents (Advanced Reasoning)
**Main Thread** - User interaction and orchestration

**Critical Reasoning Agents**:
- `knowledge-synthesizer` - Cross-domain pattern synthesis
- `code-reviewer` - Judgment and quality assessment
- `debug-troubleshooter` - Complex problem solving
- `refactor-specialist` - Architectural refactoring

### Positive Consequences
- **70% cost reduction** on research tasks
- **40-50% overall cost savings**
- **Faster research responses** with Sonnet 4
- **Maintained quality** for critical decisions
- **More affordable parallel research**
- **Scalable knowledge generation**

### Negative Consequences
- **Configuration complexity** - Need to maintain model mappings
- **Potential inconsistency** - Different models may have style variations
- **Testing overhead** - Need to verify both models work correctly

## Implementation Plan
1. ✅ Configure `settings.json` with model mappings
2. ✅ Add model field to agent definitions (optional)
3. ✅ Document model selection in this ADR
4. Monitor performance and cost metrics
5. Adjust assignments based on real-world usage

## Validation
Success metrics to track:
- Research document quality remains high
- Cost per research task decreases by >60%
- Critical decision quality maintained
- User satisfaction unchanged or improved
- Response times improve for routine tasks

## Cost Analysis

### Before (All Opus 4.1)
- Research task (10K tokens): $0.15 input + $0.75 output = $0.90
- 100 research tasks/day: $90/day

### After (Hybrid Approach)
- Research task (10K tokens): $0.03 input + $0.15 output = $0.18
- 100 research tasks/day: $18/day
- **Savings: $72/day (80% reduction)**

## Related Decisions
- [[Research-First-Methodology]] - Emphasizes high-volume research
- [[Agent-Architecture]] - Defines agent roles and responsibilities
- [[Knowledge-Management]] - Requires extensive documentation generation

## References
- [Claude 4 Family Announcement](https://www.anthropic.com/news/claude-4)
- [Claude Opus 4.1 Update](https://www.anthropic.com/news/claude-opus-4-1)
- [Anthropic Pricing](https://www.anthropic.com/pricing)

## Notes
- Model assignments can be adjusted based on usage patterns
- Consider creating task-specific model selection in future
- Monitor for new model releases that may change optimal assignments
- Sonnet 4 has 1M token context window, suitable for large codebases

---

*Decision made: 2025-08-16*  
*Review date: 2025-09-16*