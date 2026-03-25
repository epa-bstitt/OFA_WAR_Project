export type UserRole = "ADMINISTRATOR" | "PROGRAM_OVERSEER" | "AGGREGATOR" | "CONTRIBUTOR";

export interface MockUser {
  id: string;
  name: string | null;
  email: string;
  role: UserRole;
  isActive: boolean;
  createdAt: Date;
  updatedAt: Date;
  lastLoginAt: Date | null;
  azureAdId: string | null;
}

export interface MockUserStats {
  totalUsers: number;
  activeUsers: number;
  inactiveUsers: number;
  byRole: Record<UserRole, number>;
}

export interface MockAuditLog {
  id: string;
  action: string;
  resourceType: string;
  resourceId: string;
  userId: string;
  userName: string;
  details: string | null;
  ipAddress: string | null;
  userAgent: string | null;
  createdAt: Date;
}

export interface MockAuditStats {
  totalEvents: number;
  eventsByAction: Record<string, number>;
  eventsByResourceType: Record<string, number>;
}

export interface SystemSettings {
  ai: {
    serviceUrl: string;
    apiKey: string;
    timeout: number;
    enabled: boolean;
    model: string;
  };
  database: {
    connectionString: string;
    poolSize: number;
    sslEnabled: boolean;
  };
  microsoft: {
    graphClientId: string;
    graphClientSecret: string;
    tenantId: string;
    enabled: boolean;
  };
  teams: {
    botAppId: string;
    botAppPassword: string;
    enabled: boolean;
  };
  ngrok: {
    authtoken: string;
    apiKey: string;
    region: string;
    subdomain: string;
    domain: string;
    enabled: boolean;
  };
  audit: {
    retentionDays: number;
    detailedLogging: boolean;
    piiMasking: boolean;
  };
  security: {
    sessionMaxAge: number;
    maxLoginAttempts: number;
    lockoutDuration: number;
  };
}

export const mockUsers: MockUser[] = [
  {
    id: "mock-user-1",
    name: "John Administrator",
    email: "john.admin@epa.gov",
    role: "ADMINISTRATOR",
    isActive: true,
    createdAt: new Date("2024-01-15"),
    updatedAt: new Date("2024-02-19"),
    lastLoginAt: new Date("2024-02-19T08:30:00"),
    azureAdId: "mock-azure-1",
  },
  {
    id: "mock-user-2",
    name: "Sarah Overseer",
    email: "sarah.overseer@epa.gov",
    role: "PROGRAM_OVERSEER",
    isActive: true,
    createdAt: new Date("2024-01-20"),
    updatedAt: new Date("2024-02-18"),
    lastLoginAt: new Date("2024-02-18T14:22:00"),
    azureAdId: "mock-azure-2",
  },
  {
    id: "mock-user-3",
    name: "Mike Aggregator",
    email: "mike.aggregator@epa.gov",
    role: "AGGREGATOR",
    isActive: true,
    createdAt: new Date("2024-01-25"),
    updatedAt: new Date("2024-02-17"),
    lastLoginAt: new Date("2024-02-19T09:15:00"),
    azureAdId: "mock-azure-3",
  },
  {
    id: "mock-user-4",
    name: "Lisa Contributor",
    email: "lisa.contributor@epa.gov",
    role: "CONTRIBUTOR",
    isActive: true,
    createdAt: new Date("2024-02-01"),
    updatedAt: new Date("2024-02-19"),
    lastLoginAt: new Date("2024-02-19T10:00:00"),
    azureAdId: "mock-azure-4",
  },
  {
    id: "mock-user-5",
    name: "Tom Disabled",
    email: "tom.disabled@epa.gov",
    role: "CONTRIBUTOR",
    isActive: false,
    createdAt: new Date("2024-01-10"),
    updatedAt: new Date("2024-02-15"),
    lastLoginAt: new Date("2024-02-14T16:45:00"),
    azureAdId: "mock-azure-5",
  },
];

export const mockUserStats: MockUserStats = {
  totalUsers: 5,
  activeUsers: 4,
  inactiveUsers: 1,
  byRole: {
    ADMINISTRATOR: 1,
    PROGRAM_OVERSEER: 1,
    AGGREGATOR: 1,
    CONTRIBUTOR: 2,
  },
};

export const mockAuditLogs: MockAuditLog[] = [
  {
    id: "mock-audit-1",
    action: "USER_LOGIN",
    resourceType: "USER",
    resourceId: "mock-user-1",
    userId: "mock-user-1",
    userName: "John Administrator",
    details: "Successful login from web application",
    ipAddress: "192.168.1.100",
    userAgent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
    createdAt: new Date("2024-02-19T08:30:00"),
  },
  {
    id: "mock-audit-2",
    action: "SUBMISSION_CREATED",
    resourceType: "SUBMISSION",
    resourceId: "mock-submission-1",
    userId: "mock-user-4",
    userName: "Lisa Contributor",
    details: "Created weekly activity report for week of Feb 12-16",
    ipAddress: "192.168.1.102",
    userAgent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
    createdAt: new Date("2024-02-19T09:15:00"),
  },
  {
    id: "mock-audit-3",
    action: "USER_ROLE_UPDATED",
    resourceType: "USER",
    resourceId: "mock-user-4",
    userId: "mock-user-1",
    userName: "John Administrator",
    details: "Changed role from CONTRIBUTOR to AGGREGATOR",
    ipAddress: "192.168.1.100",
    userAgent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
    createdAt: new Date("2024-02-18T14:22:00"),
  },
  {
    id: "mock-audit-4",
    action: "USER_DISABLED",
    resourceType: "USER",
    resourceId: "mock-user-5",
    userId: "mock-user-1",
    userName: "John Administrator",
    details: "User account disabled - Reason: Security policy violation",
    ipAddress: "192.168.1.100",
    userAgent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
    createdAt: new Date("2024-02-15T11:30:00"),
  },
  {
    id: "mock-audit-5",
    action: "REVIEW_APPROVED",
    resourceType: "REVIEW",
    resourceId: "mock-review-1",
    userId: "mock-user-3",
    userName: "Mike Aggregator",
    details: "Approved submission with minor edits",
    ipAddress: "192.168.1.103",
    userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36",
    createdAt: new Date("2024-02-17T16:45:00"),
  },
  {
    id: "mock-audit-6",
    action: "PUBLISH_ONE_NOTE",
    resourceType: "SUBMISSION",
    resourceId: "mock-submission-2",
    userId: "mock-user-2",
    userName: "Sarah Overseer",
    details: "Published approved WAR to OneNote section 'Weekly Reports 2024'",
    ipAddress: "192.168.1.101",
    userAgent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
    createdAt: new Date("2024-02-16T10:30:00"),
  },
  {
    id: "mock-audit-7",
    action: "AI_CONVERSION",
    resourceType: "SUBMISSION",
    resourceId: "mock-submission-1",
    userId: "mock-user-4",
    userName: "Lisa Contributor",
    details: "AI converted verbose text to terse format - Confidence: 0.92",
    ipAddress: "192.168.1.102",
    userAgent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
    createdAt: new Date("2024-02-19T09:16:30"),
  },
];

export const mockAuditStats: MockAuditStats = {
  totalEvents: 42,
  eventsByAction: {
    USER_LOGIN: 15,
    SUBMISSION_CREATED: 8,
    AI_CONVERSION: 7,
    REVIEW_APPROVED: 4,
    PUBLISH_ONE_NOTE: 3,
    USER_ROLE_UPDATED: 2,
    USER_DISABLED: 1,
    OTHER: 2,
  },
  eventsByResourceType: {
    USER: 8,
    SUBMISSION: 18,
    REVIEW: 6,
    AUDIT_LOG: 2,
    OTHER: 8,
  },
};

export const defaultSystemSettings: SystemSettings = {
  ai: {
    serviceUrl: "https://demandingly-superangelic-dusty.ngrok-free.dev/v1", // OpenAI-compatible ngrok endpoint
    apiKey: "", // OpenAI-compatible API key (Bearer token)
    timeout: 5000,
    enabled: true,
    model: "gpt-4o-mini", // Default model for text conversion
  },
  database: {
    connectionString: "postgresql://localhost:5432/epabusinessplatform",
    poolSize: 20,
    sslEnabled: true,
  },
  microsoft: {
    graphClientId: "",
    graphClientSecret: "",
    tenantId: "",
    enabled: true,
  },
  teams: {
    botAppId: "",
    botAppPassword: "",
    enabled: false,
  },
  ngrok: {
    authtoken: "",
    apiKey: "",
    region: "us",
    subdomain: "",
    domain: "",
    enabled: false,
  },
  audit: {
    retentionDays: 2555, // 7 years
    detailedLogging: true,
    piiMasking: true,
  },
  security: {
    sessionMaxAge: 28800, // 8 hours
    maxLoginAttempts: 5,
    lockoutDuration: 30, // minutes
  },
};

export const auditActions = [
  "USER_LOGIN",
  "USER_LOGOUT",
  "USER_CREATED",
  "USER_UPDATED",
  "USER_DISABLED",
  "USER_ENABLED",
  "USER_ROLE_UPDATED",
  "SUBMISSION_CREATED",
  "SUBMISSION_UPDATED",
  "SUBMISSION_DELETED",
  "AI_CONVERSION",
  "REVIEW_CREATED",
  "REVIEW_APPROVED",
  "REVIEW_REJECTED",
  "PUBLISH_ONE_NOTE",
  "BATCH_APPROVE",
  "BATCH_REJECT",
  "SETTINGS_UPDATED",
  "AUDIT_LOG_EXPORTED",
];

export const resourceTypes = [
  "USER",
  "SUBMISSION",
  "REVIEW",
  "PROMPT_TEMPLATE",
  "AUDIT_LOG",
  "SETTINGS",
  "NOTIFICATION",
  "CONVERSATION_STATE",
];
