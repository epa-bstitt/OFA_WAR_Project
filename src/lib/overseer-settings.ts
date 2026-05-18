export interface ContributorAccessSettings {
  dashboardEnabled: boolean;
  contractCardsVisible: boolean;
  enhancedEditorEnabled: boolean;
  submissionEnabled: boolean;
  deadlineOverrideEnabled: boolean;
}

export interface AggregatorAccessSettings {
  reviewDashboardEnabled: boolean;
  promptTemplateManagementEnabled: boolean;
}

export interface OverseerSettings {
  contributorAccess: ContributorAccessSettings;
  aggregatorAccess: AggregatorAccessSettings;
}

export const defaultOverseerSettings: OverseerSettings = {
  contributorAccess: {
    dashboardEnabled: true,
    contractCardsVisible: true,
    enhancedEditorEnabled: true,
    submissionEnabled: true,
    deadlineOverrideEnabled: false,
  },
  aggregatorAccess: {
    reviewDashboardEnabled: true,
    promptTemplateManagementEnabled: true,
  },
};

export function getOverseerSettings(rawSettings: Record<string, unknown> | null | undefined): OverseerSettings {
  const stored = (rawSettings?.overseer as Record<string, unknown> | undefined) ?? {};
  const storedContributorAccess =
    (stored.contributorAccess as Partial<ContributorAccessSettings> | undefined) ?? {};
  const storedAggregatorAccess =
    (stored.aggregatorAccess as Partial<AggregatorAccessSettings> | undefined) ?? {};

  return {
    contributorAccess: {
      dashboardEnabled:
        storedContributorAccess.dashboardEnabled ?? defaultOverseerSettings.contributorAccess.dashboardEnabled,
      contractCardsVisible:
        storedContributorAccess.contractCardsVisible ??
        defaultOverseerSettings.contributorAccess.contractCardsVisible,
      enhancedEditorEnabled:
        storedContributorAccess.enhancedEditorEnabled ??
        defaultOverseerSettings.contributorAccess.enhancedEditorEnabled,
      submissionEnabled:
        storedContributorAccess.submissionEnabled ??
        defaultOverseerSettings.contributorAccess.submissionEnabled,
      deadlineOverrideEnabled:
        storedContributorAccess.deadlineOverrideEnabled ??
        defaultOverseerSettings.contributorAccess.deadlineOverrideEnabled,
    },
    aggregatorAccess: {
      reviewDashboardEnabled:
        storedAggregatorAccess.reviewDashboardEnabled ??
        defaultOverseerSettings.aggregatorAccess.reviewDashboardEnabled,
      promptTemplateManagementEnabled:
        storedAggregatorAccess.promptTemplateManagementEnabled ??
        defaultOverseerSettings.aggregatorAccess.promptTemplateManagementEnabled,
    },
  };
}
