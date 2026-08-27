const { spawnSync } = require("node:child_process");
const path = require("node:path");
const { getDatabaseUrlFromServices } = require("./database-url.cjs");

const databaseUrl = getDatabaseUrlFromServices();

if (!databaseUrl) {
  throw new Error("No PostgreSQL service binding was found in VCAP_SERVICES.");
}

const environment = {
  ...process.env,
  DATABASE_URL: databaseUrl,
  TARGET_DATABASE_URL: databaseUrl,
};

function run(script, args) {
  const result = spawnSync(process.execPath, [script, ...args], {
    cwd: process.cwd(),
    env: environment,
    stdio: "inherit",
  });

  if (result.error) throw result.error;
  if (result.status !== 0) process.exit(result.status ?? 1);
}

run(path.join("node_modules", "prisma", "build", "index.js"), ["migrate", "deploy"]);
run(path.join("scripts", "migrate-sqlite-to-postgres.mjs"), process.argv.slice(2));