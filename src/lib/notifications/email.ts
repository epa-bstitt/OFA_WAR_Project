import { getGraphAccessToken, isGraphConfigured } from "@/lib/graph/client";

interface SendEmailInput {
  to: string[];
  subject: string;
  textBody: string;
  htmlBody?: string;
}

function isEmailConfigured(): boolean {
  return isGraphConfigured() && Boolean(process.env.MS_GRAPH_SENDER_EMAIL);
}

export async function sendWorkflowEmail(input: SendEmailInput): Promise<{ success: boolean; error?: string }> {
  try {
    const recipients = input.to.filter(Boolean);
    if (recipients.length === 0) {
      return { success: false, error: "No recipients provided" };
    }

    if (!isEmailConfigured()) {
      console.warn("Email notification skipped: Microsoft Graph sender not configured");
      return { success: false, error: "Email service not configured" };
    }

    const token = await getGraphAccessToken();
    const sender = process.env.MS_GRAPH_SENDER_EMAIL as string;

    const response = await fetch(`https://graph.microsoft.com/v1.0/users/${encodeURIComponent(sender)}/sendMail`, {
      method: "POST",
      headers: {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        message: {
          subject: input.subject,
          body: {
            contentType: input.htmlBody ? "HTML" : "Text",
            content: input.htmlBody || input.textBody,
          },
          toRecipients: recipients.map((email) => ({
            emailAddress: { address: email },
          })),
        },
        saveToSentItems: false,
      }),
    });

    if (!response.ok) {
      const errorText = await response.text();
      return { success: false, error: `Graph sendMail failed: ${response.status} ${errorText}` };
    }

    return { success: true };
  } catch (error) {
    return {
      success: false,
      error: error instanceof Error ? error.message : "Unknown email notification error",
    };
  }
}
