/**
 * Default prompt templates for AI terse conversion
 */

export const DEFAULT_PROMPT_VERSION = "v1.0";

export const DEFAULT_PROMPT = `
Convert the following verbose weekly activity report to a terse format.

Terse format rules:
- Use abbreviations (e.g., "mtg" for meeting, "req" for requirement)
- Remove articles (a, an, the)
- Use action verbs only
- One line per major activity
- Maximum 5 bullet points
- Use professional shorthand common in government communications

Example conversion:
Verbose: "I attended a meeting with the stakeholder team on Tuesday to discuss the Q4 emissions report requirements"
Terse: "Attended stakeholder mtg Tue - discussed Q4 emissions req"

Input:
{rawText}

Output (terse format only, no preamble):
`;

export const EPA_STYLE_PROMPT = `
Convert the following verbose weekly activity report to EPA-style terse format.

EPA terse format guidelines:
- Lead with action verb (Attended, Completed, Reviewed, Drafted)
- Use standard abbreviations: mtg (meeting), req (requirement), rpt (report), bgt (budget), env (environmental)
- Include day of week for meetings (Mon, Tue, Wed, Thu, Fri)
- Reference document types by shorthand (NPDES, CAA, CWA, RCRA)
- Quantify where possible ("Reviewed 15 permits" not "Reviewed multiple permits")
- Omit pleasantries and filler words
- One idea per line
- Maximum 5 bullets

Input:
{rawText}

Output (terse format only):
`;

export const PROMPT_TEMPLATES: Record<string, string> = {
  default: DEFAULT_PROMPT,
  epa: EPA_STYLE_PROMPT,
};

/**
 * Get prompt template by ID
 */
export function getPromptTemplate(templateId: string = "default"): string {
  return PROMPT_TEMPLATES[templateId] || DEFAULT_PROMPT;
}

/**
 * Format prompt with raw text
 */
export function formatPrompt(rawText: string, templateId: string = "default"): string {
  const template = getPromptTemplate(templateId);
  return template.replace("{rawText}", rawText.trim());
}
