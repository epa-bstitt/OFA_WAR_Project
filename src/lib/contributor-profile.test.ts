import { describe, expect, it } from "vitest";
import { getContributorNameFromEmail, isContributorEmail } from "./contributor-profile";

describe("contributor email profiles", () => {
  it("accepts EPA addresses in lastname.firstname format", () => {
    expect(isContributorEmail("smith.jane@epa.gov")).toBe(true);
    expect(isContributorEmail("O'Neil.Jean-Marie@EPA.GOV")).toBe(true);
  });

  it("rejects addresses outside the required format", () => {
    expect(isContributorEmail("jane@epa.gov")).toBe(false);
    expect(isContributorEmail("jane.smith@example.gov")).toBe(false);
    expect(isContributorEmail("smith.jane.middle@epa.gov")).toBe(false);
    expect(isContributorEmail("smith_jane@epa.gov")).toBe(false);
  });

  it("derives a display name in first-last order", () => {
    expect(getContributorNameFromEmail("smith.jane@epa.gov")).toBe("Jane Smith");
    expect(getContributorNameFromEmail("oneil.jean-marie@epa.gov")).toBe("Jean-Marie Oneil");
  });
});
