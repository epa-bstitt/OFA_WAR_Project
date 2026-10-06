import { describe, expect, it } from "vitest";
import { getCurrentSubmissionPeriod, isSubmissionWindowOpen } from "./submission-periods";

describe("submission periods", () => {
  it("keeps September 16 in the September 8 biweekly period", () => {
    const period = getCurrentSubmissionPeriod(new Date("2026-09-16T12:00:00-04:00"));

    expect(period.id).toBe("2026-09-08");
  });

  it("keeps the current period through Monday before the next deadline", () => {
    const period = getCurrentSubmissionPeriod(new Date("2026-09-21T19:59:59-04:00"));

    expect(period.id).toBe("2026-09-08");
  });

  it("opens the next period Monday at 8 PM Eastern", () => {
    const period = getCurrentSubmissionPeriod(new Date("2026-09-21T20:00:00-04:00"));

    expect(period.id).toBe("2026-09-22");
  });

  it("uses Monday at 8 PM boundaries for period database queries", () => {
    const period = getCurrentSubmissionPeriod(new Date("2026-09-16T12:00:00-04:00"));

    expect(period.start.toISOString()).toBe("2026-09-08T00:00:00.000Z");
    expect(period.end.toISOString()).toBe("2026-09-21T23:59:59.999Z");
  });

  it("opens submissions Monday at 8 PM Eastern through Tuesday at 5 PM", () => {
    expect(isSubmissionWindowOpen(new Date("2026-09-21T19:59:59-04:00"))).toBe(false);
    expect(isSubmissionWindowOpen(new Date("2026-09-21T20:00:00-04:00"))).toBe(true);
    expect(isSubmissionWindowOpen(new Date("2026-09-22T17:00:00-04:00"))).toBe(true);
    expect(isSubmissionWindowOpen(new Date("2026-09-22T17:00:01-04:00"))).toBe(false);
  });
});