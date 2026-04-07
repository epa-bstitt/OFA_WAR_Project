# Login.gov EPA Authentication Setup Guide

## Overview
This guide provides step-by-step instructions for configuring Login.gov authentication for the EPA Business Platform. Login.gov is the federal government's secure sign-in service that offers two-factor authentication (2FA) and strong protections for federal systems.

## Prerequisites

1. **EPA Access**: EPA IT approval for Login.gov integration
2. **Login.gov Partner Account**: Requested through GSA
3. **Application Domain**: Public-facing HTTPS URL
4. **PKI Certificates**: EPA-approved certificate authority

## Step 1: Request Login.gov Partnership

### 1.1 Submit Partner Request

1. Visit [Login.gov Partner Portal](https://partners.login.gov/)
2. Click **Get Started** for SAML integration
3. Fill out the partner intake form:
   - **Agency**: Environmental Protection Agency (EPA)
   - **Application Name**: EPA Business Platform
   - **Application Description**: Weekly Activity Report management system
   - **FICAM Compliance**: Yes (federal employee authentication)
   - **Identity Proofing**: IAL2 (for contributors)
   - **Authentication Assurance**: AAL2 (requires 2FA)

### 1.2 EPA Security Review

Before proceeding, ensure you have:
- [ ] EPA CIO approval for external authentication
- [ ] Security Assessment & Authorization (SA&A)
- [ ] Privacy Impact Assessment (PIA)
- [ ] System Security Plan (SSP) updated

Contact EPA's Office of Information Security for guidance.

## Step 2: Configure Login.gov Dashboard

### 2.1 Access Dashboard

Once approved, GSA will provide access to the Login.gov partner dashboard.

### 2.2 Create Application Configuration

1. Log in to [Login.gov Partner Dashboard](https://dashboard.int.identitysandbox.gov/)
2. Click **Create a new app**
3. Configure:

**Basic Configuration:**
- **App name**: EPA Business Platform
- **Friendly name**: EPA WAR System
- **Description**: EPA Weekly Activity Report Management Platform
- **Agency**: EPA

**URLs:**
- **Return App URL**: `https://epa-business-platform.gov/dashboard`
- **Redirect URIs**:
  ```
  https://epa-business-platform.gov/api/auth/callback/logingov
  https://epa-business-platform.gov/auth/callback
  ```

**Authentication Settings:**
- **IAL Level**: 2 (Verified identity with 2FA)
- **AAL Level**: 2 (Two-factor authentication required)
- **Fraud Prevention**: Enabled
- **Proofing Vendor**: Experian (default)

### 2.3 Configure SAML Settings

**Issuer**: `urn:gov:gsa:openidconnect.profiles:sp:sso:epa:epa-war`

**Assertion Consumer Service (ACS) URL**:
```
https://epa-business-platform.gov/api/auth/callback/logingov
```

**Single Logout URL**:
```
https://epa-business-platform.gov/api/auth/logout
```

**NameID Format**: `urn:oasis:names:tc:SAML:2.0:nameid-format:persistent`

## Step 3: Generate Certificates

### 3.1 Create Certificate Signing Request (CSR)

```bash
# Generate private key
openssl genrsa -out logingov_private.key 2048

# Generate CSR
openssl req -new -key logingov_private.key -out logingov.csr \
  -subj "/C=US/O=U.S. Environmental Protection Agency/OU=Office of Mission Support/CN=epa-business-platform.gov"
```

### 3.2 Submit CSR to EPA PKI

1. Submit CSR through EPA's certificate management system
2. Request **SAML Signing Certificate**
3. Certificate type: **Digital Signature**
4. Validity: 2 years (per EPA policy)

### 3.3 Upload Certificate to Login.gov

1. In Login.gov dashboard, go to your app settings
2. Under **Certificates**, upload your EPA-issued certificate
3. Download Login.gov's public certificate for your application

## Step 4: Configure Application

### 4.1 Install Dependencies

```bash
npm install @logingov/passport-logingov
```

### 4.2 Environment Variables

Add to `.env.local` and Cloud.gov secrets:

```bash
# Login.gov Configuration
LOGINGOV_ISSUER=urn:gov:gsa:openidconnect.profiles:sp:sso:epa:epa-war
LOGINGOV_CLIENT_ID=your-client-id-from-dashboard
LOGINGOV_PRIVATE_KEY=-----BEGIN RSA PRIVATE KEY-----
your-private-key-here
-----END RSA PRIVATE KEY-----
LOGINGOV_CERTIFICATE=-----BEGIN CERTIFICATE-----
your-certificate-here
-----END CERTIFICATE-----
LOGINGOV_IDP_CERTIFICATE=-----BEGIN CERTIFICATE-----
logingov-public-cert-here
-----END CERTIFICATE-----
LOGINGOV_ENTRY_POINT=https://secure.login.gov/api/saml
LOGINGOV_CALLBACK_URL=https://epa-business-platform.gov/api/auth/callback/logingov
LOGINGOV_LOGOUT_URL=https://secure.login.gov/api/saml/logout

# Feature Flags
ENABLE_LOGINGOV=true
ENABLE_AZURE_AD_B2C=false  # Disable when Login.gov is active
```

### 4.3 Configure NextAuth with Login.gov

Create `src/lib/auth/logingov.ts`:

```typescript
import { SAML } from '@logingov/passport-logingov';

export const logingovConfig = {
  entryPoint: process.env.LOGINGOV_ENTRY_POINT!,
  issuer: process.env.LOGINGOV_ISSUER!,
  callbackUrl: process.env.LOGINGOV_CALLBACK_URL!,
  logoutUrl: process.env.LOGINGOV_LOGOUT_URL!,
  privateKey: process.env.LOGINGOV_PRIVATE_KEY!,
  cert: process.env.LOGINGOV_CERTIFICATE!,
  idpCert: process.env.LOGINGOV_IDP_CERTIFICATE!,
  // EPA-specific settings
  identifierFormat: 'urn:oasis:names:tc:SAML:2.0:nameid-format:persistent',
  acceptedClockSkewMs: 5000,
  requestIdExpirationPeriodMs: 3600000,
};
```

### 4.4 Update NextAuth Configuration

Update `src/lib/auth.ts` to include Login.gov provider:

```typescript
import NextAuth from "next-auth";
import { prisma } from "./db";
import { PrismaAdapter } from "@auth/prisma-adapter";
import type { Adapter } from "@auth/core/adapters";

// Import Login.gov provider when available
// import LoginGov from "@logingov/next-auth-provider";

export const {
  handlers: { GET, POST },
  auth,
  signIn,
  signOut,
} = NextAuth({
  adapter: PrismaAdapter(prisma) as Adapter,
  providers: [
    // Login.gov Provider (when library is available)
    // LoginGov({
    //   clientId: process.env.LOGINGOV_CLIENT_ID,
    //   clientSecret: process.env.LOGINGOV_PRIVATE_KEY,
    //   issuer: process.env.LOGINGOV_ENTRY_POINT,
    // }),
    
    // Keep demo login for testing
    Credentials({
      id: "demo",
      name: "Demo Login",
      credentials: { role: { label: "Role", type: "text" } },
      async authorize(credentials) {
        // Demo implementation
      },
    }),
  ],
  callbacks: {
    async jwt({ token, user }) {
      if (user) {
        token.sub = user.id;
        token.role = user.role;
        token.assuranceLevel = (user as any).assuranceLevel;
      }
      return token;
    },
    async session({ session, token }) {
      if (session.user) {
        session.user.id = token.sub!;
        session.user.role = token.role as string;
        (session.user as any).assuranceLevel = token.assuranceLevel;
      }
      return session;
    },
  },
  pages: {
    signIn: "/login",
    error: "/auth/error",
  },
});
```

## Step 5: Handle Login.gov Attributes

### 5.1 User Attributes Mapping

Login.gov returns these attributes (IAL2):

| Login.gov Attribute | EPA System Field | Description |
|--------------------|------------------|-------------|
| `uuid` | `user.externalId` | Unique persistent identifier |
| `email` | `user.email` | Verified email address |
| `first_name` | `user.firstName` | Given name |
| `last_name` | `user.lastName` | Surname |
| `phone` | `user.phone` | Verified phone number |
| `ial` | `user.assuranceLevel` | Identity assurance level |
| `aal` | `user.authenticatorAssurance` | Authentication assurance |
| `verified_at` | `user.verifiedAt` | Identity verification timestamp |

### 5.2 User Provisioning

Create user record on first login:

```typescript
// src/lib/auth/user-provisioning.ts
export async function provisionLoginGovUser(attributes: LoginGovAttributes) {
  const existingUser = await prisma.user.findUnique({
    where: { externalId: attributes.uuid },
  });

  if (existingUser) {
    // Update last login
    return prisma.user.update({
      where: { id: existingUser.id },
      data: { 
        lastLoginAt: new Date(),
        email: attributes.email, // Update if changed
      },
    });
  }

  // Create new user
  return prisma.user.create({
    data: {
      externalId: attributes.uuid,
      email: attributes.email,
      name: `${attributes.first_name} ${attributes.last_name}`,
      firstName: attributes.first_name,
      lastName: attributes.last_name,
      phone: attributes.phone,
      assuranceLevel: attributes.ial,
      authenticatorAssurance: attributes.aal,
      verifiedAt: new Date(attributes.verified_at),
      role: "CONTRIBUTOR", // Default role
      isActive: true,
    },
  });
}
```

## Step 6: Testing in Login.gov Sandbox

### 6.1 Sandbox Environment

Login.gov provides a sandbox for testing:

- **URL**: https://idp.int.identitysandbox.gov/
- **Test Users**: Create via Login.gov partner dashboard

### 6.2 Test Scenarios

1. **New User Registration**
   - Verify user is created in EPA database
   - Confirm all attributes mapped correctly

2. **Returning User**
   - Verify user matched by `uuid`
   - Check `lastLoginAt` updated

3. **Identity Proofing**
   - Test IAL2 flow (identity verification)
   - Confirm PII handling per EPA privacy policy

4. **Two-Factor Authentication**
   - Test SMS/TOTP methods
   - Verify AAL2 enforcement

5. **Logout**
   - Test SAML Single Logout (SLO)
   - Confirm session termination

## Step 7: Production Deployment

### 7.1 Production Checklist

- [ ] EPA security approval obtained
- [ ] Production certificates issued
- [ ] Login.gov production access requested
- [ ] DNS records configured
- [ ] SSL/TLS certificates installed
- [ ] Error pages customized
- [ ] Monitoring alerts configured
- [ ] Incident response plan documented

### 7.2 Go-Live Steps

1. **Schedule Maintenance Window**: Coordinate with EPA users
2. **Enable Login.gov**: Set `ENABLE_LOGINGOV=true`
3. **Disable Azure AD**: Set `ENABLE_AZURE_AD_B2C=false`
4. **Deploy**: Push changes to production
5. **Verify**: Test authentication flow
6. **Monitor**: Watch error logs closely

## Step 8: User Communication

### 8.1 User Guidance

Create user documentation covering:

1. **Creating Login.gov Account**
   - Navigate to Login.gov
   - Select "Create an account"
   - Verify email and phone
   - Complete identity proofing (IAL2)

2. **Accessing EPA Systems**
   - Visit EPA Business Platform
   - Click "Sign in with Login.gov"
   - Authenticate with Login.gov credentials
   - Accept EPA system permissions

3. **Troubleshooting**
   - Forgot password → Use Login.gov password reset
   - Lost 2FA device → Contact Login.gov support
   - Account locked → Wait 30 minutes or contact helpdesk

### 8.2 Training Materials

- Quick reference card
- Video tutorial (2-3 minutes)
- FAQ document
- Help desk escalation procedures

## Security & Compliance

### Federal Compliance Requirements

| Requirement | Login.gov Feature | EPA Implementation |
|------------|--------------------|--------------------|
| HSPD-12 | PKI integration | EPA badge integration |
| FICAM | IAL/AAL levels | Enforce IAL2/AAL2 |
| NIST 800-63 | NIST compliant | Verified attributes |
| Privacy Act | Consent management | Explicit user consent |
| Section 508 | Accessible UI | WCAG 2.1 AA compliant |

### PII Handling

1. **Collection**: Only collect necessary attributes
2. **Storage**: Encrypt at rest in database
3. **Transmission**: TLS 1.3 required
4. **Retention**: Follow EPA records schedule
5. **Disposal**: Secure deletion procedures

## Troubleshooting

### Common Issues

**Issue**: Login button redirects to error page
- Check `LOGINGOV_CALLBACK_URL` matches dashboard
- Verify certificates are valid and not expired
- Confirm system time is synchronized (NTP)

**Issue**: User attributes not populated
- Check SAML attribute mapping
- Verify Login.gov dashboard attribute release settings
- Review EPA database schema alignment

**Issue**: 2FA not enforced
- Confirm `aal:2` requested in SAML AuthnRequest
- Check Login.gov dashboard AAL settings
- Verify EPA application validates AAL in response

**Issue**: Certificate errors
- Renew certificates before expiration
- Use EPA-approved certificate authority
- Properly format PEM files

## Support Contacts

| Issue Type | Contact | Details |
|------------|---------|---------|
| Login.gov Technical | partners@login.gov | Integration support |
| Login.gov Access | GSA Identity | Partner dashboard |
| EPA Security | OIS-GRC@epa.gov | SA&A, security review |
| EPA Help Desk | ITSC@epa.gov | End user support |
| Application Issues | [Your Team] | Internal escalation |

## References

- [Login.gov Developer Documentation](https://developers.login.gov/)
- [SAML Integration Guide](https://developers.login.gov/saml/)
- [EPA Identity Management Policy](https://www.epa.gov/omshwdxb)
- [NIST 800-63 Digital Identity Guidelines](https://pages.nist.gov/800-63-3/)
- [Federal Identity, Credential, and Access Management (FICAM)](https://www.idmanagement.gov/)

---

## Migration from Azure AD B2C

If transitioning from Azure AD B2C:

1. **Parallel Operation**: Run both methods simultaneously
2. **User Migration**: Map existing Azure AD users to Login.gov
3. **Communication**: Notify users of upcoming change
4. **Cutover**: Schedule maintenance window
5. **Decommission**: Remove Azure AD B2C after 30 days

Contact EPA's Identity Management team for migration assistance.
