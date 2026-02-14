---
description: Deploy to staging or production with pre-checks and verification
---

# Deploy

## Target Environment
$ARGUMENTS (staging | production | production --skip-staging)

## Pre-Deployment Checklist

Before deploying, verify:

1. **Phase Gates Passed**
   - All phases marked complete in PROGRESS.md
   - Last `/phase-gate` result was PASS

2. **Clean Working Directory**
   - No uncommitted changes (`git status`)
   - All changes committed and pushed

3. **Environment Configuration**
   - Environment variables configured for target
   - Secrets properly set (not hardcoded)

4. **Security Scan**
   - Run security-auditor in fast mode
   - No critical vulnerabilities

## Deployment Process

1. **Build Production Bundle**
   ```bash
   npm run build
   # or: yarn build / pnpm build
   ```

2. **Deploy to Target**
   Detect platform and execute:
   - **Vercel**: `vercel --prod` or `vercel` (preview)
   - **Netlify**: `netlify deploy --prod` or `netlify deploy`
   - **AWS**: Use configured deployment script
   - **Other**: Follow project's deploy script

3. **Wait for Completion**
   - Monitor deployment progress
   - Capture deployment URL

4. **Run Health Checks**
   - Verify main endpoint responds (HTTP 200)
   - Check critical API routes
   - Verify static assets load

## Post-Deployment Validation

1. **Endpoint Verification**
   - Home page loads correctly
   - Auth endpoints respond
   - API health check passes

2. **Smoke Tests** (if configured)
   - Run `npm run test:smoke` if available
   - Verify critical user flows

3. **Error Monitoring**
   - Check error rates in monitoring (Sentry, etc.)
   - Compare to pre-deployment baseline

## Output

Provide deployment report:

```
## Deployment Report

**Environment**: staging | production
**Version**: [git SHA or tag]
**URL**: [deployment URL]
**Status**: SUCCESS | FAILED

### Health Checks
- [ ] Main endpoint: OK
- [ ] API health: OK
- [ ] Auth system: OK

### Next Steps
- For staging: Verify manually, then `/deploy production`
- For production: Monitor error rates for 15 minutes

### If Issues Occur
Run `/rollback [environment]` to revert
```

## On Failure

If deployment fails:

1. **Stop immediately** - do not proceed
2. **Capture error details** - logs, error messages
3. **Show rollback command** - `/rollback [environment]`
4. **Suggest investigation steps**

## Usage Examples

```
/deploy staging              # Deploy to staging environment
/deploy production           # Deploy to production (requires staging first)
/deploy production --skip-staging  # Force production deploy (use with caution)
```

## Safety Notes

- Always deploy to staging first
- Verify staging before production
- Keep rollback instructions handy
- Monitor error rates after deploy
