ALTER TABLE "users"
  ALTER COLUMN "azureAdId" DROP NOT NULL,
  ADD COLUMN "loginGovId" TEXT,
  ADD COLUMN "passwordHash" TEXT,
  ADD COLUMN "mustChangePassword" BOOLEAN NOT NULL DEFAULT false,
  ADD COLUMN "passwordChangedAt" TIMESTAMP(3),
  ADD COLUMN "sessionVersion" INTEGER NOT NULL DEFAULT 0;

CREATE UNIQUE INDEX "users_loginGovId_key" ON "users"("loginGovId");