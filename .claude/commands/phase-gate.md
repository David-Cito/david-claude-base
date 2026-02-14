---
description: Quality checkpoint between phases - runs tests, security scans, and reports pass/fail
---

Run a quality gate check before proceeding to the next phase.

## Phase to Validate

$ARGUMENTS

Example: `/phase-gate phase-1-foundation`

---

## Gate Process Overview

Phase gates ensure quality by verifying:
1. All tests pass
2. No security vulnerabilities
3. No TypeScript errors
4. No linting issues
5. Documentation is updated

**Gate Decision:**
- ✅ **PASS** = All checks pass → Proceed to next phase
- ❌ **FAIL** = Any check fails → Fix issues, re-run gate

---

## Step 1: Testing (test-engineer phase)

### Read Test Configuration
First, check the project's testing setup:
- Read package.json for test scripts
- Identify testing frameworks (Jest, Vitest, Playwright, etc.)
- Check for existing test configuration files

### Run All Tests

```bash
# Unit tests
npm run test:unit
# or
npm test

# E2E tests (if configured)
npm run test:e2e
# or
npx playwright test

# Visual regression (if configured)
npm run test:visual
```

### Coverage Check

If coverage reporting is configured:
- Unit test coverage target: 80%+ on utilities and business logic
- All critical user flows should have E2E coverage
- All API endpoints should have integration tests

### Test Report

```
Testing Results:
├── Unit Tests:     X passed, Y failed
├── Integration:    X passed, Y failed
├── E2E Tests:      X passed, Y failed
├── Coverage:       XX% (target: 80%)
└── Status:         ✅ PASS | ❌ FAIL
```

---

## Step 2: Security (security-auditor phase - fast mode)

### Automated Scans

```bash
# Dependency vulnerabilities
npm audit

# Secret scanning (if secretlint is installed)
npx secretlint "**/*"

# TypeScript strict mode (catches some security issues)
npx tsc --noEmit
```

### Quick Security Checklist

- [ ] No hardcoded secrets in committed code
- [ ] Environment variables used for sensitive config
- [ ] API inputs are validated
- [ ] Authentication checks on protected routes
- [ ] No console.log of sensitive data
- [ ] No TODO/FIXME comments with security implications

### Security Report

```
Security Scan Results:
├── npm audit:       X vulnerabilities (Y critical, Z high)
├── Secret scan:     X findings
├── Code review:     X concerns
└── Status:          ✅ PASS | ❌ FAIL
```

---

## Step 3: Code Quality

### TypeScript Check

```bash
npx tsc --noEmit
```

All TypeScript errors must be resolved.

### Linting

```bash
npm run lint
# or
npx eslint .
```

All linting errors must be resolved (warnings acceptable).

### Code Quality Report

```
Code Quality Results:
├── TypeScript:      X errors
├── ESLint:          X errors, Y warnings
└── Status:          ✅ PASS | ❌ FAIL
```

---

## Step 4: Documentation Check

Verify documentation is current:

- [ ] PROGRESS.md reflects completed tasks
- [ ] Any new components/APIs are documented
- [ ] README updated if setup steps changed
- [ ] Type definitions are complete

---

## Step 5: Gate Decision

### Compile Results

```
╔══════════════════════════════════════════════════════════╗
║               PHASE GATE: [Phase Name]                   ║
╠══════════════════════════════════════════════════════════╣
║                                                          ║
║  Testing:         ✅ PASS | ❌ FAIL                       ║
║  Security:        ✅ PASS | ❌ FAIL                       ║
║  Code Quality:    ✅ PASS | ❌ FAIL                       ║
║  Documentation:   ✅ PASS | ❌ FAIL                       ║
║                                                          ║
╠══════════════════════════════════════════════════════════╣
║  GATE RESULT:     ✅ PASSED | ❌ FAILED                   ║
╚══════════════════════════════════════════════════════════╝
```

### If PASSED

1. Update PROGRESS.md to mark phase complete
2. Commit changes with message: "Complete [Phase Name] - gate passed"
3. Proceed to next phase

### If FAILED

1. List all failures with specific issues
2. Prioritize by severity (Critical → High → Medium)
3. Fix issues
4. Re-run `/phase-gate` until all pass

**DO NOT proceed to the next phase with a failed gate.**

---

## Gate Requirements by Phase

### Foundation Phase Gate
- Project builds without errors
- Core components render
- Basic routing works
- Storage layer functional

### Feature Phase Gates
- All feature tests pass
- Feature works as specified
- No regressions in existing features
- Security review for new auth/data handling

### Integration Phase Gate
- All features work together
- Cross-feature interactions tested
- Performance acceptable
- No critical security issues

### Polish Phase Gate
- Visual regression tests pass
- Accessibility audit passed
- Performance metrics met
- All known bugs addressed

### Release Gate (Final)
- Comprehensive security audit (security-auditor comprehensive mode)
- Full test suite passes
- Documentation complete
- Deployment checklist verified

---

## Skipping Gates

Gates should NOT be skipped. If you need to proceed urgently:

1. Document why the gate was skipped
2. Create tasks to address failures
3. Track as technical debt
4. Plan immediate follow-up

**Never skip gates for:**
- Critical security vulnerabilities
- Failing tests on critical paths
- TypeScript errors
- Broken builds

---

## Integration with Workflow

```
Complete Phase Tasks
        ↓
  /phase-gate
        ↓
   ┌────┴────┐
   ↓         ↓
 PASS      FAIL
   ↓         ↓
Next      Fix Issues
Phase        ↓
        Re-run Gate
```

After passing a gate:
1. Update PROGRESS.md
2. Identify next phase tasks
3. Begin implementation
4. Repeat until release
