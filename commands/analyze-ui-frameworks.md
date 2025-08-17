---
description: Analyze and compare UI frameworks for React and Svelte, focusing on functionality, minimal technical debt, and customization
---

# Analyze UI Frameworks

Comprehensively analyze UI framework options for React and Svelte, prioritizing functionality over aesthetics, minimal technical debt, and customization capability.

## Your Priorities (In Order):
1. **Maximum functionality** - Get features working quickly
2. **Minimal technical debt** - Avoid vendor lock-in, easy to maintain
3. **Customization capability** - Ability to modify when needed
4. **Aesthetics later** - Function before form

## Preferred Technologies:
- shadcn/ui (copy-paste components)
- Tailwind CSS (utility-first)
- SCSS (when needed)
- Headless/unstyled components

## Analysis Instructions:

### Phase 1: Deploy Research Agents
Deploy these agents in parallel to gather comprehensive data:

1. **component-library-researcher**: Research shadcn/ui, Radix UI, Headless UI, Arco, MUI, Ant Design
2. **styling-researcher**: Analyze Tailwind vs SCSS vs CSS-in-JS for maintainability
3. **react-researcher** (if React): Research React-specific UI patterns and libraries
4. **svelte-researcher** (if Svelte): Research Svelte-specific UI solutions
5. **ui-ux-researcher**: Analyze accessibility and UX best practices

### Phase 2: Evaluation Criteria

Score each framework combination (1-10) on:

#### Functionality Score
- Number of available components
- Component feature completeness
- Form handling capabilities
- Data display components
- Navigation patterns
- Modal/dialog systems
- Animation support

#### Technical Debt Score
- Vendor lock-in risk (10 = no lock-in)
- Update frequency and breaking changes
- Community size and longevity
- Ease of migration away
- Code ownership (copy-paste vs npm)
- Bundle size impact

#### Customization Score
- Theme system flexibility
- Component override capability
- Style isolation
- Extensibility patterns
- Mix-and-match ability

#### Development Velocity
- Time to implement common patterns
- Documentation quality
- TypeScript support
- Developer experience
- Learning curve

### Phase 3: Framework-Specific Analysis

#### For React:
Research these combinations:
1. **shadcn/ui + Tailwind** - Copy-paste, no lock-in
2. **Radix UI + Tailwind/SCSS** - Headless primitives
3. **Arco Design** - Comprehensive component set
4. **MUI (Material UI)** - Full-featured but opinionated
5. **Ant Design** - Enterprise-focused
6. **Mantine** - Modern, hooks-based
7. **Chakra UI** - Modular and accessible
8. **React Aria + Custom** - Maximum control

#### For Svelte:
Research these combinations:
1. **shadcn-svelte + Tailwind** - Port of shadcn/ui
2. **Skeleton UI + Tailwind** - Svelte-native
3. **Flowbite Svelte** - Tailwind components
4. **Carbon Components Svelte** - IBM's design system
5. **Svelte Material UI** - Material Design
6. **Custom + Tailwind/SCSS** - Full control
7. **Melt UI** - Headless components for Svelte

### Phase 4: Generate Comparison Matrix

Create a matrix in `_knowledge/01-Research/UI-Frameworks/comparison-matrix-[date].md`:

```markdown
| Framework | Functionality | Tech Debt | Customization | Velocity | Bundle Size | Recommendation |
|-----------|--------------|-----------|---------------|----------|-------------|----------------|
| shadcn/ui + Tailwind | 9/10 | 10/10 | 10/10 | 8/10 | Small | ⭐ Primary |
| Radix + Tailwind | 8/10 | 9/10 | 10/10 | 7/10 | Small | Alternative |
| MUI | 10/10 | 6/10 | 7/10 | 9/10 | Large | If need everything |
```

### Phase 5: Recommendations

Based on the analysis, provide:

1. **Primary Recommendation**
   - Which framework combination to use
   - Why it best fits the criteria
   - Quick-start instructions

2. **Alternative Options**
   - When to consider alternatives
   - Trade-offs for each

3. **Implementation Guide**
   ```bash
   # Example for shadcn/ui + Tailwind
   npx shadcn-ui@latest init
   npx shadcn-ui@latest add button card form
   ```

4. **Migration Strategy**
   - If switching from current solution
   - Incremental adoption path
   - Component mapping guide

### Phase 6: Document Findings

Save comprehensive research to:
- `_knowledge/01-Research/UI-Frameworks/[framework]-analysis-[date].md`
- `_knowledge/04-Decisions/ADR-[NUM]-ui-framework-selection.md`

Include:
- Detailed analysis of each option
- Code examples
- Performance benchmarks
- Bundle size comparisons
- Community metrics (GitHub stars, npm downloads)
- Update frequency analysis
- Known limitations and gotchas

## Special Considerations:

### For Functionality-First Development:
1. Prioritize libraries with comprehensive form components
2. Look for data table/grid solutions
3. Check for complex components (date pickers, autocomplete)
4. Evaluate keyboard navigation support
5. Consider accessibility out-of-the-box

### For Minimal Technical Debt:
1. Prefer copy-paste over npm dependencies
2. Choose libraries with stable APIs
3. Avoid highly opinionated solutions
4. Consider long-term maintenance burden
5. Evaluate ease of testing

### For Customization:
1. Prefer unstyled/headless components
2. Ensure theme system is flexible
3. Check for CSS variable support
4. Evaluate component composition patterns
5. Consider style isolation methods

## Expected Output:

```markdown
# UI Framework Analysis Report

## 🏆 Recommendation: shadcn/ui + Tailwind CSS

### Why This Combination Wins:
- **Zero vendor lock-in** - You own the code
- **44+ components** ready to use
- **Highly customizable** - Modify anything
- **Small bundle** - Only ship what you use
- **Great DX** - TypeScript, accessibility built-in

### Quick Start:
[Installation and setup instructions]

### Component Coverage:
✅ Forms (all input types)
✅ Data Display (tables, cards, lists)
✅ Feedback (alerts, toasts, modals)
✅ Navigation (menus, tabs, breadcrumbs)
✅ Complex (date picker, command palette)

### Customization Example:
[Code showing how to customize]

## 📊 Full Comparison Matrix:
[Detailed comparison table]

## 🔄 Migration Path:
[If switching from another library]
```

$ARGUMENTS