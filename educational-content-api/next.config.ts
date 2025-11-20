import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  turbopack: {},
  outputFileTracingIncludes: {
    "/app/api/process-articles/route": ["./lib/scripts/**/*"],
  },
  webpack: (config) => {
    config.resolve = config.resolve || {};
    config.resolve.fallback = {
      ...config.resolve.fallback,
      encoding: false,
      fs: false,
      path: false,
    };
    return config;
  },
};

export default nextConfig;
