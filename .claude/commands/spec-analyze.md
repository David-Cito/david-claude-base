---
description: Deep analysis of spec to find gaps, ask clarifying questions, and prevent AI drift
---

Analyze the project specification as a Senior Code Developer to identify gaps, ambiguities, and missing details that could cause AI drift during implementation.

## Spec to Analyze

$ARGUMENTS

If no arguments provided, look for `PROJECT-SPEC.md` or `stretchflow-spec.md` in the project root.

## Analysis Framework

### 1. Read Project Context

First, read the project's CLAUDE.md to understand:
- Tech stack and coding standards
- Project structure conventions
- Safety rules and constraints

### 2. Gap Analysis

Systematically identify:

**Missing Requirements**
- Features mentioned but not fully specified
- User flows without complete steps
- Data models with undefined fields
- Edge cases not addressed

**Undefined Edge Cases**
- What happens when things fail?
- Empty states and zero-data scenarios
- Maximum limits not specified
- Error handling not defined

**Unclear Acceptance Criteria**
- How do we know when it's "done"?
- What does success look like?
- How do we test this works?

**Ambiguous Terminology**
- Terms used inconsistently
- Technical jargon without definitions
- Concepts that could be interpreted multiple ways

### 3. Clarifying Questions

For each gap identified, formulate a specific question:

**Good Questions:**
- "What should happen when a user uploads an image larger than 10MB?"
- "Should the timer continue running when the app is backgrounded?"
- "Is there a maximum number of stretches allowed per routine?"

**Bad Questions (too vague):**
- "Can you tell me more about the feature?"
- "What are the requirements?"

### 4. Anti-Drift Detailing

For each feature, the spec should include:

**Explicit "DO" List**
- Specific behaviors to implement
- Exact data to capture/display
- Precise user interactions

**Explicit "DO NOT" List**
- Features explicitly out of scope
- Over-engineering to avoid
- Future enhancements to defer

**Exact Behavior Descriptions**
- "When X happens, Y should occur"
- Specific UI states and transitions
- Error messages and handling

**Boundary Conditions**
- Minimum/maximum values
- Required vs. optional fields
- Supported formats and types

### 5. Security & Data Considerations

Check for missing specifications around:
- Authentication requirements
- Authorization (who can do what)
- Data validation rules
- Privacy considerations
- Error message content (no sensitive data leak)

## Output Format

### Gaps Found

List each gap with:
1. **Area**: Which part of the spec
2. **Gap**: What's missing or unclear
3. **Impact**: What could go wrong without clarification
4. **Suggestion**: Potential resolution if obvious

### Clarifying Questions

Number each question for easy reference:

1. **[Feature Name]** Question text here?
   - Context: Why this matters
   - Options: A, B, or C (if applicable)

2. **[Feature Name]** Another question?
   - Context: Why this matters

### DO NOT Sections to Add

Suggest explicit "DO NOT" constraints to add to the spec:

```markdown
## DO NOT (Scope Control)
- DO NOT implement [feature] - defer to POST-MVP
- DO NOT add [complexity] - keep it simple
- DO NOT optimize for [scenario] - not needed for MVP
```

### Next Steps

After answering the questions:
1. Update the spec with clarifications
2. Run `/spec-analyze` again to check for remaining gaps
3. When no more gaps found, proceed to `/spec-expand`

## Iteration

This command is designed to be run multiple times:

1. **First run**: Identifies major gaps, asks initial questions
2. **After answers**: Run again to find any new gaps from clarifications
3. **Final run**: Confirms spec is detailed enough for implementation

The spec is ready for `/spec-expand` when this command returns:
> "No significant gaps found. Spec is ready for task breakdown."

## Remember

- The goal is to prevent AI drift during implementation
- Detailed specs lead to consistent output across sessions
- "DO NOT" sections are as important as "DO" sections
- Better to ask now than to build wrong later
