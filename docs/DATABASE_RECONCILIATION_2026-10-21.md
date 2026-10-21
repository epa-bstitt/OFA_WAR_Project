# Local SQLite and cloud.gov PostgreSQL reconciliation (2026-10-21)

## Scope

Source: `prisma/dev-db.sqlite` in the local workspace. Reference: the `epa-db` service bound to `epa-business-platform` in the cloud.gov `epa-prototyping/admin-training` space. Counts were read without changing either database. Local SQLite passed the migration script's relationship validation; its SHA-256 at the start of the inventory was `dc91b3abad59237cf3fd645c3df532176b6d11633ff1e5615b33c57b9f1caf99`. This is a point-in-time comparison, not a live mirror: a subsequent attempt to rehash the local file was blocked by another process holding it open.

| Model | Local SQLite | cloud.gov PostgreSQL | Production minus local |
| --- | ---: | ---: | ---: |
| User | 14 | 13 | -1 |
| Project | 41 | 41 | 0 |
| ProjectComponent | 0 | 0 | 0 |
| Contract | 0 | 0 | 0 |
| PromptTemplate | 0 | 0 | 0 |
| ConversationState | 0 | 0 | 0 |
| ImportJob | 12 | 12 | 0 |
| ImportJobFileResult | 431 | 431 | 0 |
| ProjectAssignment | 35 | 37 | +2 |
| Submission | 414 | 421 | +7 |
| Review | 1 | 3 | +2 |
| WorkflowState | 1 | 0 | -1 |
| AuditLog | 53 | 44 | -9 |
| Notification | 0 | 0 | 0 |

## Record-level comparison

Identifiers and complete rows were independently SHA-256 fingerprinted on each side. Only fingerprints, counts, and role/status totals were compared; credentials, names, and record contents were not exported. A shared ID with a different row fingerprint is a changed record, not proof of which individual column changed.

| Model | Only local | Only cloud.gov | Shared IDs with changed rows |
| --- | ---: | ---: | ---: |
| User | 4 | 3 | 10 |
| Project | 0 | 0 | 3 |
| ProjectAssignment | 2 | 4 | 0 |
| Submission | 3 | 10 | 0 |
| Review | 1 | 3 | 0 |
| WorkflowState | 1 | 0 | 0 |
| AuditLog | 9 | 0 | 0 |

ImportJob and ImportJobFileResult have matching identifiers **and** full-row fingerprints. All models with zero rows match. Project identifiers match, but three project rows differ. User rows include authentication-related fields, so their ten changed-row fingerprints do not by themselves establish which passwords, roles, or session versions differ.

| Distribution | Local SQLite | cloud.gov PostgreSQL |
| --- | --- | --- |
| User role | 8 contributor, 1 aggregator, 4 overseer, 1 admin | 10 contributor, 1 aggregator, 1 overseer, 1 admin |
| Project status | 34 active, 7 completed | 33 active, 8 completed |
| Submission status | 412 approved, 2 submitted | 414 approved, 3 in review, 4 submitted |
| Review status | 1 approved | 3 approved |

## Application impact

- The user-role distribution differs materially. Different users, role/activation data, password hashes, or session versions can change login, work-mode access, and who appears on review cards; no credentials were compared or copied in the clear.
- Three changed projects and one fewer active project in production can change contract cards and assignment visibility.
- Two additional net assignments in production and ten cloud-only submissions (versus three local-only) can change missing-project counts, contributor status, and the `/review` queue. Three production submissions are `IN_REVIEW`, versus none locally.
- Review differences can change approval state and the reviewer statistics shown on review and approval screens.
- The local-only workflow state can change the stage displayed for a submission. Nine local-only audit records must not be silently discarded; they change troubleshooting and compliance history.
- Equal row counts do not establish equal identifiers or field values. In particular, user passwords, roles, and session versions must not be replaced based on row counts.

## Reconciliation status

The tables above describe the pre-replacement differences. Production was subsequently replaced from the verified local snapshot as described below; those differences are no longer the current database state.

## Requested replacement: local SQLite is now the source of truth

The user authorized replacing production PostgreSQL rows with the local SQLite contents. This supersedes the earlier comparison direction, **not** its historical results. The uploaded SQLite snapshot passed relationship validation with SHA-256 `dc91b3abad59237cf3fd645c3df532176b6d11633ff1e5615b33c57b9f1caf99`.

The user authorized relying on cloud.gov's support-assisted RDS point-in-time recovery rather than a manual export. The recovery point immediately before maintenance was recorded at 2026-10-21 08:38:12 EDT; restoration may take time and can lose up to five minutes of data. A temporary no-route, no-start app received the private SQLite snapshot and a bound Postgres connection. The public app was stopped to prevent writes. The migration replaced rows in one transaction, verified matching counts and full-row SHA-256 hashes for all 14 models inside the transaction and again after commit, and finished at approximately 08:38:45 EDT. The public app was then pushed and returned to 1/1 running. A live read-only query confirmed 14 users, 414 submissions, 35 assignments, and 1 review; both named accounts had the expected roles, activation status, and password-change flags. The temporary cloud app and its local staging copy were removed; the original local SQLite file was not changed.

Account effects of an exact local replacement (flags checked without printing password hashes):

| Account | Local SQLite | cloud.gov PostgreSQL |
| --- | --- | --- |
| `beja.jake@epa.gov` | Active Aggregator; password present; `mustChangePassword=false`; session version 3 | Active Contributor; password present; `mustChangePassword=true`; session version 1 |
| `stitt.brian@epa.gov` | Active Contributor; password present; `mustChangePassword=true`; session version 1 | Active Contributor; password present; `mustChangePassword=false`; session version 1 |

Replacing accounts changed their password hashes, forced-change prompts, session versions, and sign-in behavior to match the local snapshot. It also removed production-only users/submissions/reviews and changed active project and role counts as listed above. Both users' three-mode access is granted by email in `src/lib/work-modes.ts`; it does not depend on their stored base role. A password change still requires the current password and a new password of at least 12 characters. The password-change screen is accessible to any active user, including users not marked `mustChangePassword`.

The database runtime selector uses SQLite outside Cloud Foundry and requires a PostgreSQL URL inside Cloud Foundry. Focused selector, work-mode, and password tests passed (17 tests); the cloud runtime probe reported `cloud=true` and a `postgres` URL. The changed application code was deployed manually after the import. Automatic GitHub-to-cloud.gov deployment is configured separately in `.github/workflows/deploy-cloudgov.yml` and requires GitHub environment secrets before it can run.