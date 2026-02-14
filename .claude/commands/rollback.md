---
description: Emergency rollback to previous deployment with health verification
---

# Rollback

## Target Environment
$ARGUMENTS (staging | production [--to version])

## Pre-Rollback Assessment

Before rolling back:

1. **Identify Current Version**
   - Get current deployed version/SHA
   - Note when it was deployed

2. **List Rollback Targets**
   - Show available previous deployments
   - Highlight recommended rollback target (usually previous)

3. **Check for Data Migration Conflicts**
   - Were there database migrations?
   - Are migrations reversible?
   - Warn if rollback may cause data issues

4. **Confirm Rollback**
   - Show what version we're rolling back FROM
   - Show what version we're rolling back TO
   - Warn about any potential issues

## Rollback Execution

1. **Trigger Rollback**
   Detect platform and execute:
   - **Vercel**: `vercel rollback` or `vercel promote [deployment-url]`
   - **Netlify**: `netlify deploy --prod -d [previous-deploy-id]`
   - **AWS**: Use configured rollback procedure
   - **Git-based**: Deploy previous commit

2. **Wait for Completion**
   - Monitor rollback progress
   - Confirm deployment switched

3. **Verify Switch**
   - Check version endpoint
   - Confirm we're on the expected version

## Post-Rollback Verification

1. **Health Checks**
   - Main endpoint responds
   - API endpoints working
   - Auth system functional

2. **Error Rate Check**
   - Compare current error rate to pre-issue baseline
   - Verify errors dropped after rollback

3. **Critical Flows**
   - Test most important user flows
   - Verify core functionality restored

## Documentation

After successful rollback:

1. **Log the Event**
   ```markdown
   ## Rollback Event - [DATE]

   **From**: [version/SHA]
   **To**: [version/SHA]
   **Reason**: [brief description]
   **Duration**: [how long bad version was live]
   ```

2. **Create Incident Note**
   - What went wrong
   - How it was detected
   - Time to rollback

3. **Flag for Post-Mortem**
   - Mark issue for investigation
   - Don't forget root cause analysis

## Output

Provide rollback report:

```
## Rollback Report

**Environment**: staging | production
**Rolled Back From**: [version/SHA]
**Rolled Back To**: [version/SHA]
**Status**: SUCCESS | FAILED

### Health Checks (Post-Rollback)
- [ ] Main endpoint: OK
- [ ] API health: OK
- [ ] Error rates: NORMAL

### Incident Summary
- **Detection time**: [when issue was noticed]
- **Rollback time**: [when rollback completed]
- **Total impact duration**: [time]

### Next Steps
1. Investigate root cause
2. Fix the issue in development
3. Add tests to prevent recurrence
4. Re-deploy when ready

### Post-Mortem Reminder
Schedule post-mortem within 24 hours to review:
- What caused the issue?
- How was it detected?
- How can we prevent it?
```

## On Failure

If rollback fails:

1. **Escalate immediately** - this is critical
2. **Try manual rollback** - direct platform console
3. **Consider maintenance mode** - if available
4. **Document everything** - for incident review

## Usage Examples

```
/rollback staging              # Roll back staging to previous version
/rollback production           # Roll back production to previous version
/rollback production --to v1.2.2  # Roll back to specific version
```

## Safety Notes

- Rollback is an emergency action
- Always verify health after rollback
- Don't skip the post-mortem
- Fix forward when possible (new deploy vs rollback)
