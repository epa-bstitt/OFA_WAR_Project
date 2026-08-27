import { cp, mkdir } from "node:fs/promises";
import path from "node:path";

const rootDir = process.cwd();
const standaloneDir = path.join(rootDir, ".next", "standalone");
const sourceStaticDir = path.join(rootDir, ".next", "static");
const targetStaticDir = path.join(standaloneDir, ".next", "static");
const sourcePublicDir = path.join(rootDir, "public");
const targetPublicDir = path.join(standaloneDir, "public");

await mkdir(path.dirname(targetStaticDir), { recursive: true });
await cp(sourceStaticDir, targetStaticDir, { recursive: true });

try {
  await cp(sourcePublicDir, targetPublicDir, { recursive: true });
} catch (error) {
  if (error && typeof error === "object" && "code" in error && error.code === "ENOENT") {
    // public/ is optional in this app.
  } else {
    throw error;
  }
}