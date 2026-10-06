import JSZip from "jszip";
import { describe, expect, it } from "vitest";
import { buildDocxBuffer } from "./route";

describe("WAR overview Word export", () => {
  it("creates a valid document with category summary-table content", async () => {
    const buffer = await buildDocxBuffer(
      [
        {
          category: "outlook",
          contractName: "T-Mobile (EMDC)",
          contributorName: "Jake Beja",
          contributorEmail: "beja.jake@epa.gov",
          weekOf: new Date("2026-09-16T13:42:57.474Z"),
          updatedAt: new Date("2026-09-16T13:42:57.474Z"),
          status: "APPROVED",
          rawText: "Mobile contract update submitted.",
        },
      ],
      new Date("2026-09-08T21:00:00.000Z")
    );

    const archive = await JSZip.loadAsync(buffer);
    const documentXml = await archive.file("word/document.xml")?.async("string");

    expect(documentXml).toBeTruthy();
    expect(documentXml).toContain("Week of Sep 8, 2026");
    expect(documentXml).toContain("Current and Active Contracts/Purchase Order Outlook");
    expect(documentXml).toContain("T-Mobile (EMDC)");
    expect(documentXml).toContain("Jake Beja");
    expect(documentXml).toContain("Mobile contract update submitted.");
    expect(documentXml).toContain("<w:tbl>");
  });
});