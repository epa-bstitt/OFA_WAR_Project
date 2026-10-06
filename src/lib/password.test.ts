import { beforeAll, describe, expect, it, vi } from "vitest";

vi.mock("server-only", () => ({}));

let passwordModule: typeof import("./password");

beforeAll(async () => {
  passwordModule = await import("./password");
});

describe("password security", () => {
  it("normalizes EPA login emails", () => {
    expect(passwordModule.normalizeLoginEmail("  Person.Name@EPA.GOV ")).toBe(
      "person.name@epa.gov"
    );
  });

  it("accepts only EPA email addresses", () => {
    expect(passwordModule.isEpaEmail("person.name@epa.gov")).toBe(true);
    expect(passwordModule.isEpaEmail("person.name@example.gov")).toBe(false);
    expect(passwordModule.isEpaEmail("not-an-email")).toBe(false);
  });

  it("requires permanent passwords to contain at least 12 characters", () => {
    expect(passwordModule.validateNewPassword("EPA123")).not.toBeNull();
    expect(passwordModule.validateNewPassword("a secure passphrase")).toBeNull();
  });

  it("rejects passwords beyond bcrypt's safe input size", () => {
    expect(passwordModule.validateNewPassword("a".repeat(73))).not.toBeNull();
  });

  it("creates unique hashes and verifies only the correct password", async () => {
    const firstHash = await passwordModule.hashPassword("EPA123");
    const secondHash = await passwordModule.hashPassword("EPA123");

    expect(firstHash).not.toBe("EPA123");
    expect(secondHash).not.toBe(firstHash);
    await expect(passwordModule.verifyPassword("EPA123", firstHash)).resolves.toBe(true);
    await expect(passwordModule.verifyPassword("incorrect", firstHash)).resolves.toBe(false);
  });
});