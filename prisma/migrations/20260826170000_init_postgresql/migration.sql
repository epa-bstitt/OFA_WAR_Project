-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT,
    "azureAdId" TEXT NOT NULL,
    "role" TEXT NOT NULL DEFAULT 'CONTRIBUTOR',
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "teamsNotificationsEnabled" BOOLEAN NOT NULL DEFAULT true,
    "teamsConversationId" TEXT,
    "teamsConversationReference" TEXT,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "import_jobs" (
    "id" TEXT NOT NULL,
    "initiatedById" TEXT,
    "archiveName" TEXT NOT NULL,
    "archiveHash" TEXT,
    "dryRun" BOOLEAN NOT NULL DEFAULT true,
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "filesProcessed" INTEGER NOT NULL DEFAULT 0,
    "projectsUpserted" INTEGER NOT NULL DEFAULT 0,
    "usersUpserted" INTEGER NOT NULL DEFAULT 0,
    "assignmentsCreated" INTEGER NOT NULL DEFAULT 0,
    "submissionsCreated" INTEGER NOT NULL DEFAULT 0,
    "warnings" TEXT,
    "errorMessage" TEXT,
    "startedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "import_jobs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "import_job_file_results" (
    "id" TEXT NOT NULL,
    "jobId" TEXT NOT NULL,
    "sourcePath" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "projectId" TEXT,
    "status" TEXT NOT NULL DEFAULT 'COMPLETED',
    "message" TEXT,
    "usersUpserted" INTEGER NOT NULL DEFAULT 0,
    "assignmentsCreated" INTEGER NOT NULL DEFAULT 0,
    "submissionsCreated" INTEGER NOT NULL DEFAULT 0,
    "warnings" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "import_job_file_results_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contracts" (
    "id" TEXT NOT NULL,
    "contractName" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "assigneeId" TEXT,
    "imageUrl" TEXT,
    "imageAlt" TEXT,
    "cor" TEXT,
    "contractNumber" TEXT,
    "office" TEXT,
    "nextPeriodOfPerf" TEXT,
    "ultimateCompletionDate" TEXT,
    "co" TEXT,
    "cs" TEXT,
    "orderNumber" TEXT,
    "currentUpdatePlaceholder" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "contracts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "submissions" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "projectId" TEXT,
    "componentId" TEXT,
    "contractId" TEXT,
    "weekOf" TIMESTAMP(3) NOT NULL,
    "rawText" TEXT NOT NULL,
    "terseText" TEXT,
    "terseVersion" TEXT,
    "aiConfidence" DOUBLE PRECISION,
    "status" TEXT NOT NULL DEFAULT 'SUBMITTED',
    "isAiGenerated" BOOLEAN NOT NULL DEFAULT true,
    "editedBy" TEXT,
    "publishedAt" TIMESTAMP(3),
    "oneNotePageId" TEXT,
    "deletedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "submissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "reviews" (
    "id" TEXT NOT NULL,
    "submissionId" TEXT NOT NULL,
    "reviewerId" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "comment" TEXT,
    "originalText" TEXT,
    "editedText" TEXT,
    "editReason" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reviews_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "workflow_states" (
    "id" TEXT NOT NULL,
    "submissionId" TEXT NOT NULL,
    "currentStage" TEXT NOT NULL DEFAULT 'SUBMISSION',
    "assignedTo" TEXT,
    "dueDate" TIMESTAMP(3),
    "notes" TEXT,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "workflow_states_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "prompt_templates" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "version" INTEGER NOT NULL DEFAULT 1,
    "content" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdBy" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "prompt_templates_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "audit_logs" (
    "id" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "userId" TEXT,
    "resourceType" TEXT NOT NULL,
    "resourceId" TEXT,
    "metadata" TEXT,
    "ipAddress" TEXT,
    "userAgent" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "audit_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notifications" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "isRead" BOOLEAN NOT NULL DEFAULT false,
    "metadata" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "notifications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "conversation_states" (
    "id" TEXT NOT NULL,
    "conversationId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "lastMessage" TEXT,
    "context" TEXT,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "conversation_states_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "projects" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "status" TEXT NOT NULL DEFAULT 'ACTIVE',
    "createdBy" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "projects_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "project_components" (
    "id" TEXT NOT NULL,
    "projectId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "project_components_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "project_assignments" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "projectId" TEXT NOT NULL,
    "componentId" TEXT,
    "assignedBy" TEXT,
    "assignedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "project_assignments_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "users_azureAdId_key" ON "users"("azureAdId");

-- CreateIndex
CREATE INDEX "import_jobs_initiatedById_idx" ON "import_jobs"("initiatedById");

-- CreateIndex
CREATE INDEX "import_jobs_status_idx" ON "import_jobs"("status");

-- CreateIndex
CREATE INDEX "import_jobs_createdAt_idx" ON "import_jobs"("createdAt");

-- CreateIndex
CREATE INDEX "import_job_file_results_jobId_idx" ON "import_job_file_results"("jobId");

-- CreateIndex
CREATE INDEX "import_job_file_results_status_idx" ON "import_job_file_results"("status");

-- CreateIndex
CREATE INDEX "contracts_assigneeId_idx" ON "contracts"("assigneeId");

-- CreateIndex
CREATE INDEX "contracts_category_idx" ON "contracts"("category");

-- CreateIndex
CREATE INDEX "submissions_userId_idx" ON "submissions"("userId");

-- CreateIndex
CREATE INDEX "submissions_projectId_idx" ON "submissions"("projectId");

-- CreateIndex
CREATE INDEX "submissions_componentId_idx" ON "submissions"("componentId");

-- CreateIndex
CREATE INDEX "submissions_contractId_idx" ON "submissions"("contractId");

-- CreateIndex
CREATE INDEX "submissions_weekOf_idx" ON "submissions"("weekOf");

-- CreateIndex
CREATE INDEX "submissions_status_idx" ON "submissions"("status");

-- CreateIndex
CREATE INDEX "reviews_submissionId_idx" ON "reviews"("submissionId");

-- CreateIndex
CREATE INDEX "reviews_reviewerId_idx" ON "reviews"("reviewerId");

-- CreateIndex
CREATE UNIQUE INDEX "workflow_states_submissionId_key" ON "workflow_states"("submissionId");

-- CreateIndex
CREATE UNIQUE INDEX "prompt_templates_name_key" ON "prompt_templates"("name");

-- CreateIndex
CREATE INDEX "prompt_templates_isActive_idx" ON "prompt_templates"("isActive");

-- CreateIndex
CREATE INDEX "audit_logs_userId_idx" ON "audit_logs"("userId");

-- CreateIndex
CREATE INDEX "audit_logs_resourceId_idx" ON "audit_logs"("resourceId");

-- CreateIndex
CREATE INDEX "audit_logs_createdAt_idx" ON "audit_logs"("createdAt");

-- CreateIndex
CREATE INDEX "audit_logs_action_idx" ON "audit_logs"("action");

-- CreateIndex
CREATE INDEX "notifications_userId_idx" ON "notifications"("userId");

-- CreateIndex
CREATE INDEX "notifications_isRead_idx" ON "notifications"("isRead");

-- CreateIndex
CREATE UNIQUE INDEX "conversation_states_conversationId_key" ON "conversation_states"("conversationId");

-- CreateIndex
CREATE INDEX "conversation_states_conversationId_idx" ON "conversation_states"("conversationId");

-- CreateIndex
CREATE INDEX "conversation_states_userId_idx" ON "conversation_states"("userId");

-- CreateIndex
CREATE INDEX "projects_status_idx" ON "projects"("status");

-- CreateIndex
CREATE INDEX "project_components_projectId_idx" ON "project_components"("projectId");

-- CreateIndex
CREATE INDEX "project_assignments_userId_idx" ON "project_assignments"("userId");

-- CreateIndex
CREATE INDEX "project_assignments_projectId_idx" ON "project_assignments"("projectId");

-- CreateIndex
CREATE UNIQUE INDEX "project_assignments_userId_projectId_componentId_key" ON "project_assignments"("userId", "projectId", "componentId");

-- AddForeignKey
ALTER TABLE "import_jobs" ADD CONSTRAINT "import_jobs_initiatedById_fkey" FOREIGN KEY ("initiatedById") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "import_job_file_results" ADD CONSTRAINT "import_job_file_results_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "import_jobs"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contracts" ADD CONSTRAINT "contracts_assigneeId_fkey" FOREIGN KEY ("assigneeId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "submissions" ADD CONSTRAINT "submissions_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "submissions" ADD CONSTRAINT "submissions_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "projects"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "submissions" ADD CONSTRAINT "submissions_componentId_fkey" FOREIGN KEY ("componentId") REFERENCES "project_components"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "submissions" ADD CONSTRAINT "submissions_contractId_fkey" FOREIGN KEY ("contractId") REFERENCES "contracts"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reviews" ADD CONSTRAINT "reviews_submissionId_fkey" FOREIGN KEY ("submissionId") REFERENCES "submissions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reviews" ADD CONSTRAINT "reviews_reviewerId_fkey" FOREIGN KEY ("reviewerId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workflow_states" ADD CONSTRAINT "workflow_states_submissionId_fkey" FOREIGN KEY ("submissionId") REFERENCES "submissions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_logs" ADD CONSTRAINT "audit_logs_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project_components" ADD CONSTRAINT "project_components_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "projects"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project_assignments" ADD CONSTRAINT "project_assignments_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project_assignments" ADD CONSTRAINT "project_assignments_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "projects"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project_assignments" ADD CONSTRAINT "project_assignments_componentId_fkey" FOREIGN KEY ("componentId") REFERENCES "project_components"("id") ON DELETE CASCADE ON UPDATE CASCADE;
