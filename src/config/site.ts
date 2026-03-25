export const siteConfig = {
  name: "EPA Business Platform",
  description: "Weekly Activity Report Management System",
  url: process.env.NEXTAUTH_URL || "http://localhost:3000",
  ogImage: "/og-image.png",
  links: {
    epa: "https://www.epa.gov",
    support: "mailto:support@epa.gov",
  },
};

export const ROLES = {
  CONTRIBUTOR: "CONTRIBUTOR",
  AGGREGATOR: "AGGREGATOR",
  PROGRAM_OVERSEER: "PROGRAM_OVERSEER",
  ADMINISTRATOR: "ADMINISTRATOR",
} as const;

export const SUBMISSION_STATUS = {
  SUBMITTED: "SUBMITTED",
  IN_REVIEW: "IN_REVIEW",
  APPROVED: "APPROVED",
  PUBLISHED: "PUBLISHED",
  REJECTED: "REJECTED",
} as const;

export const WORKFLOW_STAGES = {
  SUBMISSION: "SUBMISSION",
  REVIEW: "REVIEW",
  APPROVAL: "APPROVAL",
} as const;

// Role display names for UI
export const ROLE_DISPLAY_NAMES: Record<string, string> = {
  [ROLES.CONTRIBUTOR]: "Contributor",
  [ROLES.AGGREGATOR]: "Aggregator (Jake)",
  [ROLES.PROGRAM_OVERSEER]: "Program Overseer (Will)",
  [ROLES.ADMINISTRATOR]: "Administrator",
};

// Status display configurations for UI
export const STATUS_DISPLAY = {
  [SUBMISSION_STATUS.SUBMITTED]: { label: "Submitted", color: "blue" },
  [SUBMISSION_STATUS.IN_REVIEW]: { label: "In Review", color: "yellow" },
  [SUBMISSION_STATUS.APPROVED]: { label: "Approved", color: "green" },
  [SUBMISSION_STATUS.PUBLISHED]: { label: "Published", color: "purple" },
  [SUBMISSION_STATUS.REJECTED]: { label: "Rejected", color: "red" },
} as const;
