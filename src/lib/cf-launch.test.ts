import { spawnSync } from "node:child_process";
import { copyFileSync, mkdtempSync, mkdirSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import path from "node:path";
import { describe, expect, it } from "vitest";

function runLaunch(migrationExitCode = 0) {
  const root = mkdtempSync(path.join(tmpdir(), "cf-launch-test-"));
  const scripts = path.join(root, "scripts");
  const standalone = path.join(root, ".next", "standalone");
  const events = path.join(root, "startup-events");

  mkdirSync(scripts, { recursive: true });
  mkdirSync(standalone, { recursive: true });
  copyFileSync(path.join(process.cwd(), "scripts", "cf-launch.cjs"), path.join(scripts, "cf-launch.cjs"));
  copyFileSync(path.join(process.cwd(), "scripts", "database-url.cjs"), path.join(scripts, "database-url.cjs"));
  writeFileSync(
    path.join(scripts, "cf-migrate.cjs"),
    `require("node:fs").appendFileSync(process.env.STARTUP_EVENTS, "migration\\n"); process.exit(Number(process.env.MIGRATION_EXIT_CODE));`,
  );
  writeFileSync(
    path.join(standalone, "server.js"),
    `require("node:fs").appendFileSync(process.env.STARTUP_EVENTS, "server\\n");`,
  );

  try {
    const result = spawnSync(process.execPath, [path.join(scripts, "cf-launch.cjs")], {
      cwd: root,
      encoding: "utf8",
      env: {
        ...process.env,
        MIGRATION_EXIT_CODE: String(migrationExitCode),
        STARTUP_EVENTS: events,
        VCAP_SERVICES: JSON.stringify({
          "aws-rds": [{ label: "aws-rds", credentials: { uri: "postgresql://example.invalid/test" } }],
        }),
      },
    });

    return {
      events: readFileSync(events, "utf8"),
      result,
    };
  } finally {
    rmSync(root, { recursive: true, force: true });
  }
}

describe("Cloud Foundry app startup", () => {
  it("runs database migrations before starting the server", () => {
    const { events, result } = runLaunch();

    expect(result.status).toBe(0);
    expect(events).toBe("migration\nserver\n");
  });

  it("does not start the server when migrations fail", () => {
    const { events, result } = runLaunch(1);

    expect(result.status).toBe(1);
    expect(events).toBe("migration\n");
  });
});
