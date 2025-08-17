---
date: [YYYY-MM-DD]
status: [Proposed | Accepted | Deprecated | Superseded]
deciders: [List of people involved]
consulted: [List of people consulted]
informed: [List of people informed]
tags: [#adr, #architecture, #decision]
---

# ADR-[NUMBER]: [TITLE]

## Status
[Proposed | Accepted | Deprecated | Superseded by ADR-XXX]

## Context
[Describe the context and problem statement. What is the issue that we're seeing that is motivating this decision or change? Provide enough detail so that someone unfamiliar with the project can understand the situation.]

## Decision Drivers
- [Driver 1: e.g., Performance requirements]
- [Driver 2: e.g., Development velocity]
- [Driver 3: e.g., Maintainability]
- [Driver 4: e.g., Cost constraints]

## Considered Options
1. **Option 1**: [Brief description]
2. **Option 2**: [Brief description]
3. **Option 3**: [Brief description]

## Decision Outcome
Chosen option: **"[Option X]"**, because [justification. e.g., it best addresses our key decision drivers...]

### Positive Consequences
- [Positive outcome 1]
- [Positive outcome 2]
- [Positive outcome 3]

### Negative Consequences
- [Negative outcome 1]
- [Negative outcome 2]
- [Trade-off accepted]

## Options Analysis

### Option 1: [Name]
**Description**: [Detailed description of the option]

**Pros**:
- [Advantage 1]
- [Advantage 2]

**Cons**:
- [Disadvantage 1]
- [Disadvantage 2]

**Evaluation**:
- Performance: [Rating/Assessment]
- Complexity: [Rating/Assessment]
- Cost: [Rating/Assessment]
- Risk: [Rating/Assessment]

### Option 2: [Name]
**Description**: [Detailed description of the option]

**Pros**:
- [Advantage 1]
- [Advantage 2]

**Cons**:
- [Disadvantage 1]
- [Disadvantage 2]

**Evaluation**:
- Performance: [Rating/Assessment]
- Complexity: [Rating/Assessment]
- Cost: [Rating/Assessment]
- Risk: [Rating/Assessment]

### Option 3: [Name]
**Description**: [Detailed description of the option]

**Pros**:
- [Advantage 1]
- [Advantage 2]

**Cons**:
- [Disadvantage 1]
- [Disadvantage 2]

**Evaluation**:
- Performance: [Rating/Assessment]
- Complexity: [Rating/Assessment]
- Cost: [Rating/Assessment]
- Risk: [Rating/Assessment]

## Implementation Plan
1. [Step 1: What needs to be done first]
2. [Step 2: Next action]
3. [Step 3: Following action]
4. [Step 4: Validation/testing]

## Validation
[How will we validate that this decision was correct? What metrics or criteria will we use?]

## Related Decisions
- [[ADR-XXX]]: [How it relates]
- [[Pattern-Name]]: [Relevant pattern]
- [[Research-Document]]: [Supporting research]

## References
- [Link to relevant documentation]
- [Link to research or articles]
- [Link to similar decisions in other projects]

## Notes
[Any additional context, discussions, or considerations that don't fit in the sections above]

---

## Template Usage Instructions

### When to Create an ADR
Create an ADR when:
- Selecting between architectural patterns
- Choosing frameworks or libraries
- Making infrastructure decisions
- Defining coding standards
- Establishing security policies
- Deciding on data models
- Any decision with long-term impact

### Status Definitions
- **Proposed**: The decision is being discussed
- **Accepted**: The decision has been approved and should be implemented
- **Deprecated**: The decision is no longer recommended but may still be in use
- **Superseded**: The decision has been replaced by another ADR

### Evaluation Criteria Examples
- **Performance**: Response time, throughput, resource usage
- **Complexity**: Implementation effort, learning curve, maintenance burden
- **Cost**: License fees, infrastructure costs, development time
- **Risk**: Security concerns, vendor lock-in, scalability limits

### File Naming Convention
`ADR-[NUMBER]-[kebab-case-title].md`
Example: `ADR-001-database-selection.md`

### Linking ADRs
- Use wiki-links to reference other ADRs: `[[ADR-002]]`
- Link to patterns: `[[Repository-Pattern]]`
- Link to research: `[[Database-Research-2024-01-16]]`