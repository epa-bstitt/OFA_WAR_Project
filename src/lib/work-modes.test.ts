import { describe, expect, it } from "vitest";
import {
  getAllowedWorkModes,
  getDefaultWorkMode,
  getValidatedWorkMode,
  getWorkModeLandingPath,
} from "./work-modes";

describe("work modes", () => {
  it("allows aggregators to use contributor and aggregator modes", () => {
    expect(getAllowedWorkModes("AGGREGATOR")).toEqual(["CONTRIBUTOR", "AGGREGATOR"]);
  });

  it("allows Jake Beja to use contributor, aggregator, and program overseer modes", () => {
    expect(getAllowedWorkModes("CONTRIBUTOR", "import-jake-beja", "beja.jake@epa.gov")).toEqual([
      "CONTRIBUTOR",
      "AGGREGATOR",
      "PROGRAM_OVERSEER",
    ]);
    expect(getValidatedWorkMode("CONTRIBUTOR", "PROGRAM_OVERSEER", "import-jake-beja", "beja.jake@epa.gov")).toBe(
      "PROGRAM_OVERSEER"
    );
  });

  it("allows Brian Stitt to use contributor, aggregator, and program overseer modes", () => {
    expect(getAllowedWorkModes("CONTRIBUTOR", undefined, "stitt.brian@epa.gov")).toEqual([
      "CONTRIBUTOR",
      "AGGREGATOR",
      "PROGRAM_OVERSEER",
    ]);
    expect(getValidatedWorkMode("CONTRIBUTOR", "PROGRAM_OVERSEER", undefined, "stitt.brian@epa.gov")).toBe(
      "PROGRAM_OVERSEER"
    );
  });

  it("allows program overseers to use aggregator and overseer modes", () => {
    expect(getAllowedWorkModes("PROGRAM_OVERSEER")).toEqual([
      "AGGREGATOR",
      "PROGRAM_OVERSEER",
    ]);
  });

  it("rejects forged modes and falls back to stored authority", () => {
    expect(getValidatedWorkMode("CONTRIBUTOR", "ADMINISTRATOR")).toBe("CONTRIBUTOR");
    expect(getValidatedWorkMode("AGGREGATOR", "PROGRAM_OVERSEER")).toBe("AGGREGATOR");
    expect(getValidatedWorkMode("PROGRAM_OVERSEER", "CONTRIBUTOR")).toBe("PROGRAM_OVERSEER");
  });

  it("defaults Jake Beja to contributor mode while preserving aggregator authority", () => {
    expect(getDefaultWorkMode("AGGREGATOR", "import-jake-beja", "beja.jake@epa.gov")).toBe(
      "CONTRIBUTOR"
    );
    expect(getValidatedWorkMode("AGGREGATOR", null, "import-jake-beja", "beja.jake@epa.gov")).toBe(
      "CONTRIBUTOR"
    );
  });

  it("defaults Brian Stitt to contributor mode while preserving aggregator authority", () => {
    expect(getDefaultWorkMode("AGGREGATOR", undefined, "stitt.brian@epa.gov")).toBe("CONTRIBUTOR");
    expect(getValidatedWorkMode("AGGREGATOR", null, undefined, "stitt.brian@epa.gov")).toBe("CONTRIBUTOR");
  });

  it("maps each business mode to its landing page", () => {
    expect(getWorkModeLandingPath("CONTRIBUTOR")).toBe("/dashboard");
    expect(getWorkModeLandingPath("AGGREGATOR")).toBe("/review");
    expect(getWorkModeLandingPath("PROGRAM_OVERSEER")).toBe("/approve");
  });
});