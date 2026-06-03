/** @type {import('next').NextConfig} */
const enforceStrictTypes =
	process.env.CI === "true" || process.env.ENFORCE_STRICT_TYPES === "true";

const nextConfig = {
	eslint: {
		ignoreDuringBuilds: false,
	},
	typescript: {
		ignoreBuildErrors: !enforceStrictTypes,
	},
};

export default nextConfig;
