import { auth } from "@/lib/auth";

export default auth;

export const config = {
  matcher: [
    // Protected routes requiring authentication
    "/dashboard/:path*",
    "/review/:path*",
    "/approve/:path*",
    "/admin/:path*",
    "/submit/:path*",
    "/api/submissions/:path*",
    "/api/review/:path*",
    "/api/approve/:path*",
    "/api/admin/:path*",
    // Exclude public routes and auth callbacks
    "/((?!api/auth|_next/static|_next/image|favicon.ico|public|login|$).*)",
  ],
};
