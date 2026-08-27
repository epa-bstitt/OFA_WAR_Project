const path = require("node:path");
const { getDatabaseUrlFromServices } = require("./database-url.cjs");

if (!process.env.DATABASE_URL) {
  process.env.DATABASE_URL = getDatabaseUrlFromServices();
}

if (!process.env.DATABASE_URL) {
  throw new Error("DATABASE_URL is not set and no PostgreSQL service binding was found.");
}

require(path.join(process.cwd(), ".next", "standalone", "server.js"));