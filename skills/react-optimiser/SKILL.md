---
name: react-optimiser
description: Analyses React components for performance issues and implements optimisations. Use when reviewing component performance, addressing re-render issues, or when asked to optimise React code.
disable-model-invocation: true
---

When optimising React components:

1. **Analyse first**: Examine the component for:
   - Unnecessary re-renders (missing React.memo, useCallback, useMemo)
   - Expensive computations in render
   - Large inline objects/arrays in JSX
   - Props drilling and context overuse
   - Improper dependency arrays in hooks
   - Key prop issues in lists

2. **Create optimisation plan**: List specific issues found with:
   - Current problem and performance impact
   - Proposed solution
   - **Potential side-effects** (e.g., stale closures, reference equality assumptions)
   - Priority (critical/moderate/minor)

3. **Wait for approval**: Present the plan and ask which optimisations to implement.

4. **Implement carefully**: When requested:
   - Apply changes incrementally
   - Preserve existing functionality
   - Highlight any behavioural changes

Focus on React and TypeScript performance patterns only. Avoid project-wide configuration changes.
