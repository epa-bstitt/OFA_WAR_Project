const { spawnSync } = require("node:child_process");
const path = require("node:path");
const { getDatabaseUrlFromServices } = require("./database-url.cjs");

if (!process.env.DATABASE_URL) {
  process.env.DATABASE_URL = getDatabaseUrlFromServices();
}

if (!process.env.DATABASE_URL) {
  throw new Error("DATABASE_URL is not set and no PostgreSQL service binding was found.");
}

const migration = spawnSync(
  process.execPath,
  [path.join(__dirname, "cf-migrate.cjs"), "--migrate-only"],
  { cwd: process.cwd(), stdio: "inherit" },
);

if (migration.error) throw migration.error;
if (migration.status !== 0) process.exit(migration.status ?? 1);

require(path.join(process.cwd(), ".next", "standalone", "server.js"));