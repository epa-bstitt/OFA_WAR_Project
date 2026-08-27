function getDatabaseUrlFromServices(rawServices = process.env.VCAP_SERVICES) {
  if (!rawServices) return undefined;

  const services = JSON.parse(rawServices);
  const rdsService = Object.values(services)
    .flat()
    .find((service) => service?.label === "aws-rds" || service?.tags?.includes("postgresql"));
  const credentials = rdsService?.credentials;

  if (!credentials) return undefined;
  if (credentials.uri) return credentials.uri;
  if (credentials.database_uri) return credentials.database_uri;

  const host = credentials.host ?? credentials.hostname;
  const database = credentials.db_name ?? credentials.database ?? credentials.name;
  const username = credentials.username ?? credentials.user;
  const password = credentials.password;
  const port = credentials.port ?? 5432;

  if (!host || !database || !username || !password) return undefined;

  return `postgresql://${encodeURIComponent(username)}:${encodeURIComponent(password)}@${host}:${port}/${database}?sslmode=require`;
}

module.exports = { getDatabaseUrlFromServices };