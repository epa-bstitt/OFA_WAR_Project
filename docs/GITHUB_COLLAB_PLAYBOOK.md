# GitHub Collaboration Playbook (Brian + Jake)

## Goal
Use GitHub in a way that prevents overwriting each other's frontend/backend changes.

## Rules
1. Do not commit directly to `main`.
2. Every change goes on a personal feature branch.
3. Merge to `main` only through Pull Requests (PRs).
4. Rebase your branch on latest `origin/main` before final review/merge.
5. Never force-push to `main`.
6. If force-pushing your own branch, use `--force-with-lease` only.

## Branch Naming
- `bstitt/feature-<short-topic>`
- `jbeja/feature-<short-topic>`
- `bstitt/fix-<short-topic>`
- `jbeja/fix-<short-topic>`

Examples:
- `bstitt/feature-cloudgov-auth`
- `jbeja/feature-review-dashboard-ui`

## Daily Workflow
### 1) Start clean from main
```bash
git checkout main
git pull origin main
```

### 2) Create or switch to your feature branch
```bash
git checkout -b bstitt/feature-some-change
# or
git checkout bstitt/feature-some-change
```

### 3) Commit small, focused changes
```bash
git add .
git commit -m "feat: short description"
```

### 4) Push branch
```bash
git push -u origin bstitt/feature-some-change
```

### 5) Open PR to main
- Keep PR scope small.
- Ask for review from the other person.

### 6) Sync branch before merge
```bash
git fetch origin
git rebase origin/main
# resolve conflicts, then
git push --force-with-lease
```

## Conflict Avoidance Strategy
1. Split ownership by area when possible:
   - Frontend-heavy: `src/components/**`, `src/app/**`
   - Backend-heavy: `src/app/api/**`, `src/lib/**`, `prisma/**`
2. If both need the same file, coordinate first in PR comments.
3. Merge the PR touching shared files first, then rebase the other branch immediately.

## Required GitHub Branch Protection for main
Enable these settings on `main`:
1. Require a pull request before merging.
2. Require at least 1 approval.
3. Require status checks to pass.
4. Dismiss stale approvals when new commits are pushed.
5. Block force pushes.

## Safe Commands Reference
### Update your branch with latest main
```bash
git fetch origin
git rebase origin/main
```

### Push rebased branch safely
```bash
git push --force-with-lease
```

### Bring teammate branch locally
```bash
git fetch origin
git checkout jbeja/feature-some-change
```

## Repo Hygiene
1. Never commit `.env`.
2. Never commit local sqlite files unless intentional.
3. Keep secrets in Cloud.gov services or secure env management.
4. Keep PRs reviewable: smaller is safer.

## Optional Team Enhancements
1. Add `CODEOWNERS` for frontend/backend paths.
2. Add a PR template with checklist:
   - Rebased on latest `main`
   - Tested locally
   - No secrets/local artifacts committed
3. Prefer squash merge for cleaner history.
