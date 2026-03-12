---
description: DEPRECATED - Use /spec-expand instead (analysis is now built-in)
---

# DEPRECATED

This command has been merged into `/spec-expand`.

The `/spec-expand` command now includes:
1. **Phase 1: Analysis & Clarification** - Asks minimum 5 questions, loops until AI is confident
2. **Phase 2: Document Generation** - Creates specs, tasks, progress files

## Use Instead

```
/spec-expand [spec-file]
```

The new command will:
- Automatically analyze the spec for gaps
- Ask clarifying questions (minimum 5)
- Keep asking until AI determines no ambiguity remains
- Then generate all documentation

---

**Why merged?**
- Ensures clarification always happens before expansion
- AI controls when to proceed (not user)
- Single command workflow is simpler
- Prevents skipping the analysis step
