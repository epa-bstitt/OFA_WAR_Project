import { cookies } from "next/headers";

const MOCK_MODE_COOKIE = "admin-mock-mode";

/**
 * Check if mock mode is enabled from cookies
 * Use this in server components and server actions
 */
export function isMockModeEnabled(): boolean {
  try {
    const cookieStore = cookies();
    const mockMode = cookieStore.get(MOCK_MODE_COOKIE);
    return mockMode?.value === "true";
  } catch {
    // If cookies() fails (e.g., in static generation), return false
    return false;
  }
}

/**
 * Set mock mode cookie
 * Use this in server actions
 */
export async function setMockMode(enabled: boolean): Promise<void> {
  const cookieStore = cookies();
  cookieStore.set(MOCK_MODE_COOKIE, enabled.toString(), {
    httpOnly: false, // Allow JavaScript access for client-side toggle
    secure: process.env.NODE_ENV === "production",
    sameSite: "lax",
    maxAge: 60 * 60 * 24 * 7, // 7 days
    path: "/",
  });
}
