import { describe, expect, it } from "vitest";
import { createImpersonationToken, readImpersonationToken } from "./impersonation";

describe("impersonation tokens", () => {
  it("accepts the admin's signed token", () => {
    expect(readImpersonationToken(createImpersonationToken("admin", "user", 1000), "admin", 2000)).toBe("user");
  });

  it("rejects another admin and expired tokens", () => {
    const token = createImpersonationToken("admin", "user", 1000);
    expect(readImpersonationToken(token, "other", 2000)).toBeNull();
    expect(readImpersonationToken(token, "admin", 3601000)).toBeNull();
  });

  it("rejects tampered tokens", () => {
    const [, signature] = createImpersonationToken("admin", "user", 1000).split(".");
    const forged = Buffer.from(JSON.stringify({ adminId: "admin", targetId: "other", expiresAt: 3601000 })).toString("base64url");
    expect(readImpersonationToken(`${forged}.${signature}`, "admin", 2000)).toBeNull();
    expect(readImpersonationToken("invalid", "admin", 2000)).toBeNull();
  });
});