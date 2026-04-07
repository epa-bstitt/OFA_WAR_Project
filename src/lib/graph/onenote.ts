import { getGraphAccessToken, isGraphConfigured } from "./client";

export { isGraphConfigured } from "./client";

export interface OneNotePage {
  id: string;
  title: string;
  contentUrl: string;
  links: {
    oneNoteClientUrl?: {
      href: string;
    };
    oneNoteWebUrl?: {
      href: string;
    };
  };
}

export interface OneNoteSection {
  id: string;
  displayName: string;
  pagesUrl: string;
}

/**
 * Check if a page with the given title already exists in the section
 */
export async function pageExists(sectionId: string, title: string): Promise<boolean> {
  try {
    const pages = await listPages(sectionId);
    return pages.some((page) => page.title === title);
  } catch (error) {
    console.error("Error checking if page exists:", error);
    return false;
  }
}

/**
 * List all pages in a section
 */
export async function listPages(sectionId: string): Promise<OneNotePage[]> {
  if (!isGraphConfigured()) {
    throw new Error("Microsoft Graph is not configured");
  }

  const token = await getGraphAccessToken();

  const response = await fetch(
    `https://graph.microsoft.com/v1.0/me/onenote/sections/${sectionId}/pages`,
    {
      headers: {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json",
      },
    }
  );

  if (!response.ok) {
    throw new Error(`Failed to list pages: ${response.status} ${response.statusText}`);
  }

  const data = await response.json();
  return data.value || [];
}

/**
 * Get section details
 */
export async function getSection(sectionId: string): Promise<OneNoteSection | null> {
  if (!isGraphConfigured()) {
    throw new Error("Microsoft Graph is not configured");
  }

  const token = await getGraphAccessToken();

  const response = await fetch(
    `https://graph.microsoft.com/v1.0/me/onenote/sections/${sectionId}`,
    {
      headers: {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json",
      },
    }
  );

  if (!response.ok) {
    if (response.status === 404) {
      return null;
    }
    throw new Error(`Failed to get section: ${response.status} ${response.statusText}`);
  }

  return response.json();
}

/**
 * Create a new OneNote page in the specified section
 */
export async function createPage(
  title: string,
  htmlContent: string,
  sectionId: string
): Promise<OneNotePage> {
  if (!isGraphConfigured()) {
    throw new Error("Microsoft Graph is not configured");
  }

  const token = await getGraphAccessToken();

  // Build the multipart request
  const boundary = `----WebKitFormBoundary${Date.now()}`;
  const body = [
    `------${boundary}`,
    'Content-Disposition: form-data; name="Presentation"',
    "Content-Type: text/html",
    "",
    htmlContent,
    `------${boundary}--`,
  ].join("\r\n");

  const response = await fetch(
    `https://graph.microsoft.com/v1.0/me/onenote/sections/${sectionId}/pages`,
    {
      method: "POST",
      headers: {
        Authorization: `Bearer ${token}`,
        "Content-Type": `multipart/form-data; boundary=----${boundary}`,
      },
      body,
    }
  );

  if (!response.ok) {
    const error = await response.text();
    throw new Error(`Failed to create OneNote page: ${response.status} ${response.statusText} - ${error}`);
  }

  return response.json();
}

/**
 * Format WAR submissions into OneNote HTML
 */
export function formatWARContent(
  submissions: Array<{
    user: { name: string | null; email: string };
    terseText: string | null;
    year: number;
    weekNumber: number;
    createdAt: Date;
  }>,
  weekStart: string,
  weekEnd: string
): string {
  const header = `
    <h1>EPA Weekly Activity Reports</h1>
    <h2>Week of ${weekStart} - ${weekEnd}</h2>
    <p><em>Published on ${new Date().toLocaleDateString()}</em></p>
    <hr/>
  `;

  const submissionsHtml = submissions
    .map((sub) => {
      const contributorName = sub.user.name || sub.user.email;
      return `
        <div style="margin-bottom: 20px;">
          <p><strong>${contributorName}:</strong></p>
          <p style="margin-left: 20px;">${sub.terseText || "N/A"}</p>
        </div>
      `;
    })
    .join("");

  const footer = `
    <hr/>
    <p><em>Total submissions: ${submissions.length}</em></p>
    <p><em>Published via EPA WAR Platform</em></p>
  `;

  return `
    <!DOCTYPE html>
    <html>
    <head>
      <title>EPA WAR - Week of ${weekStart}</title>
    </head>
    <body>
      ${header}
      ${submissionsHtml}
      ${footer}
    </body>
    </html>
  `;
}

/**
 * List available OneNote sections
 */
export async function listSections(): Promise<OneNoteSection[]> {
  if (!isGraphConfigured()) {
    throw new Error("Microsoft Graph is not configured");
  }

  const token = await getGraphAccessToken();

  const response = await fetch(
    `https://graph.microsoft.com/v1.0/me/onenote/sections`,
    {
      headers: {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json",
      },
    }
  );

  if (!response.ok) {
    throw new Error(`Failed to list sections: ${response.status} ${response.statusText}`);
  }

  const data = await response.json();
  return data.value || [];
}
