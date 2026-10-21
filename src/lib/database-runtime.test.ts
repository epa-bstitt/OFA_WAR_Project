import { describe, expect, it } from "vitest";
import { resolveDatabaseRuntime } from "./database-runtime";

describe("database runtime selection", () => {
  it("uses SQLite locally even if a Postgres URL is present", () => {
    const config = resolveDatabaseRuntime({ DATABASE_URL: "postgresql://example.invalid/test" }, "/app");
    expect(config.provider).toBe("sqlite");
    expect(config.url).toMatch(/\/app\/prisma\/dev-db\.sqlite$/);
  });

  it("uses the configured SQLite file locally", () => {
    expect(resolveDatabaseRuntime({ DATABASE_URL: "file:./dev.db" }).provider).toBe("sqlite");
  });

  it("requires Postgres when running on cloud.gov", () => {
    const cloud = { VCAP_APPLICATION: "{}", DATABASE_URL: "postgresql://example.invalid/test" };
    expect(resolveDatabaseRuntime(cloud).provider).toBe("postgresql");
    expect(() => resolveDatabaseRuntime({ ...cloud, DATABASE_URL: "file:./dev.db" })).toThrow(
      "Cloud.gov requires a PostgreSQL DATABASE_URL."
    );
  });
});