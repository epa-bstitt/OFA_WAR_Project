import path from "node:path";

export function resolveDatabaseRuntime(env: NodeJS.ProcessEnv, workingDirectory = process.cwd()) {
  if (env.VCAP_APPLICATION || env.CF_INSTANCE_GUID) {
    if (!/^postgres(?:ql)?:\/\//.test(env.DATABASE_URL ?? "")) {
      throw new Error("Cloud.gov requires a PostgreSQL DATABASE_URL.");
    }
    return { provider: "postgresql" as const, url: env.DATABASE_URL! };
  }

  const url = env.DATABASE_URL?.startsWith("file:")
    ? env.DATABASE_URL
    : `file:${path.resolve(workingDirectory, "prisma/dev-db.sqlite").replaceAll("\\", "/")}`;
  return { provider: "sqlite" as const, url };
}