const EMAIL_DOMAIN = "epa.gov";

function normalizeToken(value: string) {
  return value.toLowerCase().replace(/[^a-z0-9]+/g, "").trim();
}

function titleCaseToken(value: string) {
  if (!value) {
    return "";
  }

  const [firstCharacter, ...rest] = value;
  return `${firstCharacter.toUpperCase()}${rest.join("").toLowerCase()}`;
}

export function normalizeContributorName(value: string) {
  const trimmed = value.trim();
  if (!trimmed) {
    return "";
  }

  const withoutImportPrefix = trimmed.replace(/^import[-_\s]+/i, "");
  const normalized = withoutImportPrefix
    .replace(/[._-]+/g, " ")
    .split(/\s+/)
    .map((part) => part.trim())
    .filter(Boolean)
    .map(titleCaseToken)
    .join(" ");

  return normalized || titleCaseToken(trimmed);
}

export function buildContributorEmail(name: string, fallbackId?: string) {
  const normalizedName = normalizeContributorName(name);
  const nameParts = normalizedName.split(/\s+/).filter(Boolean);

  if (nameParts.length >= 2) {
    const firstName = normalizeToken(nameParts[0]);
    const lastName = normalizeToken(nameParts[nameParts.length - 1]);

    if (firstName && lastName) {
      return `${lastName}.${firstName}@${EMAIL_DOMAIN}`;
    }
  }

  const fallbackSource = (fallbackId ?? normalizedName).trim();
  const fallback = fallbackSource
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, ".")
    .replace(/\.+/g, ".")
    .replace(/^\.|\.$/g, "");

  return fallback ? `${fallback}@${EMAIL_DOMAIN}` : "";
}

export function isPlaceholderContributorName(value: string | null | undefined, userId?: string) {
  const normalized = value?.trim().toLowerCase();
  if (!normalized) {
    return true;
  }

  if (userId && normalized === userId.trim().toLowerCase()) {
    return true;
  }

  return normalized.startsWith("import-") || normalized === "contributor" || normalized.startsWith("demo-");
}

export function isPlaceholderContributorEmail(value: string | null | undefined) {
  const normalized = value?.trim().toLowerCase();
  if (!normalized) {
    return true;
  }

  return normalized.endsWith("@demo.epa.gov") || normalized.endsWith("@import.local");
}