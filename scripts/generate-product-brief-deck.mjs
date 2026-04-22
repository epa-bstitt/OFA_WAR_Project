import fs from "fs/promises";
import path from "path";
import PptxGenJS from "pptxgenjs";

const workspaceRoot = process.cwd();
const outputDir = path.join(workspaceRoot, "_bmad-output", "planning-artifacts");
const outputFile = path.join(outputDir, "EPABusinessPlatform-Product-Brief-Deck.pptx");

const colors = {
  navy: "163A5F",
  blue: "2E6DA4",
  cyan: "5DA9E9",
  teal: "0F766E",
  green: "2F855A",
  gold: "C48A00",
  coral: "B45309",
  ink: "1F2937",
  slate: "475467",
  mist: "EEF4F7",
  ice: "DCEAF4",
  white: "FFFFFF",
  paleGreen: "E8F5EE",
  paleGold: "FFF4D6",
  paleCoral: "FDE7DA",
};

const deck = new PptxGenJS();
deck.layout = "LAYOUT_WIDE";
deck.author = "GitHub Copilot";
deck.company = "EPA";
deck.subject = "EPABusinessPlatform Product Brief";
deck.title = "EPABusinessPlatform Product Brief";
deck.lang = "en-US";
deck.theme = {
  headFontFace: "Aptos Display",
  bodyFontFace: "Aptos",
  lang: "en-US",
};
deck.defineSlideMaster({
  title: "EPA_MASTER",
  background: { color: colors.white },
  objects: [
    { rect: { x: 0, y: 0, w: 13.333, h: 0.32, fill: { color: colors.navy }, line: { color: colors.navy } } },
    { rect: { x: 0, y: 7.18, w: 13.333, h: 0.32, fill: { color: colors.navy }, line: { color: colors.navy } } },
    { text: { text: "EPABusinessPlatform | Weekly Activity Report Modernization", options: { x: 0.5, y: 7.22, w: 7.6, h: 0.12, fontFace: "Aptos", fontSize: 9, color: colors.white, margin: 0 } } },
  ],
  slideNumber: { x: 12.45, y: 7.2, w: 0.35, h: 0.14, color: colors.white, fontFace: "Aptos", fontSize: 9 },
});

function svgDataUri(svg) {
  return `data:image/svg+xml;base64,${Buffer.from(svg).toString("base64")}`;
}

function esc(value) {
  return String(value)
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#39;");
}

function addTitle(slide, eyebrow, title, subtitle) {
  slide.addText(eyebrow, {
    x: 0.6,
    y: 0.5,
    w: 4.4,
    h: 0.3,
    fontFace: "Aptos",
    fontSize: 12,
    bold: true,
    color: colors.blue,
    margin: 0,
  });
  slide.addText(title, {
    x: 0.6,
    y: 0.8,
    w: 7,
    h: 0.7,
    fontFace: "Aptos Display",
    fontSize: 25,
    bold: true,
    color: colors.ink,
    margin: 0,
    fit: "shrink",
  });
  if (subtitle) {
    slide.addText(subtitle, {
      x: 0.6,
      y: 1.45,
      w: 6.8,
      h: 0.48,
      fontFace: "Aptos",
      fontSize: 12,
      color: colors.slate,
      margin: 0,
      breakLine: false,
      fit: "shrink",
    });
  }
}

function addBullets(slide, items, x, y, w, h, options = {}) {
  const runs = [];
  items.forEach((item, index) => {
    runs.push({ text: item, options: { bullet: { indent: 14 } } });
    if (index < items.length - 1) {
      runs.push({ text: "\n" });
    }
  });
  slide.addText(runs, {
    x,
    y,
    w,
    h,
    fontFace: "Aptos",
    fontSize: options.fontSize ?? 14,
    color: options.color ?? colors.ink,
    margin: 0.04,
    paraSpaceAfterPt: options.paraSpaceAfterPt ?? 8,
    breakLine: false,
    fit: "shrink",
    valign: options.valign ?? "top",
  });
}

function addCard(slide, x, y, w, h, title, body, accent, fill = colors.white) {
  slide.addShape(deck.ShapeType.roundRect, {
    x,
    y,
    w,
    h,
    rectRadius: 0.08,
    fill: { color: fill },
    line: { color: accent, pt: 1.5 },
    shadow: { type: "outer", color: "B8C7D1", blur: 2, angle: 45, distance: 1, opacity: 0.12 },
  });
  slide.addShape(deck.ShapeType.rect, {
    x: x + 0.15,
    y: y + 0.18,
    w: 0.08,
    h: h - 0.36,
    fill: { color: accent },
    line: { color: accent, pt: 0 },
  });
  slide.addText(title, {
    x: x + 0.33,
    y: y + 0.18,
    w: w - 0.45,
    h: 0.34,
    fontFace: "Aptos Display",
    fontSize: 16,
    bold: true,
    color: colors.ink,
    margin: 0,
    fit: "shrink",
  });
  slide.addText(body, {
    x: x + 0.33,
    y: y + 0.56,
    w: w - 0.45,
    h: h - 0.7,
    fontFace: "Aptos",
    fontSize: 11.5,
    color: colors.slate,
    margin: 0,
    fit: "shrink",
    valign: "top",
  });
}

function addMetric(slide, x, y, w, h, value, label, accent) {
  slide.addShape(deck.ShapeType.roundRect, {
    x,
    y,
    w,
    h,
    rectRadius: 0.08,
    fill: { color: colors.white },
    line: { color: accent, pt: 1.25 },
  });
  slide.addText(value, {
    x: x + 0.18,
    y: y + 0.16,
    w: w - 0.36,
    h: 0.36,
    fontFace: "Aptos Display",
    fontSize: 22,
    bold: true,
    color: accent,
    margin: 0,
    align: "center",
  });
  slide.addText(label, {
    x: x + 0.18,
    y: y + 0.58,
    w: w - 0.36,
    h: 0.4,
    fontFace: "Aptos",
    fontSize: 10.5,
    color: colors.slate,
    margin: 0,
    align: "center",
    fit: "shrink",
  });
}

function illustrationFrame(slide, title, subtitle, svg, x = 8.15, y = 0.85, w = 4.55, h = 5.85) {
  slide.addShape(deck.ShapeType.roundRect, {
    x,
    y,
    w,
    h,
    rectRadius: 0.08,
    fill: { color: colors.mist },
    line: { color: colors.ice, pt: 1 },
  });
  slide.addText(title, {
    x: x + 0.22,
    y: y + 0.2,
    w: w - 0.44,
    h: 0.3,
    fontFace: "Aptos Display",
    fontSize: 15,
    bold: true,
    color: colors.ink,
    margin: 0,
  });
  slide.addText(subtitle, {
    x: x + 0.22,
    y: y + 0.52,
    w: w - 0.44,
    h: 0.35,
    fontFace: "Aptos",
    fontSize: 10.5,
    color: colors.slate,
    margin: 0,
    fit: "shrink",
  });
  slide.addImage({ data: svgDataUri(svg), x: x + 0.2, y: y + 0.95, w: w - 0.4, h: h - 1.15 });
}

function heroSvg() {
  return `
  <svg xmlns="http://www.w3.org/2000/svg" width="900" height="560" viewBox="0 0 900 560">
    <defs>
      <linearGradient id="bg" x1="0" y1="0" x2="1" y2="1">
        <stop offset="0%" stop-color="#EEF4F7"/>
        <stop offset="100%" stop-color="#DCEAF4"/>
      </linearGradient>
    </defs>
    <rect width="900" height="560" rx="28" fill="url(#bg)"/>
    <circle cx="120" cy="120" r="70" fill="#5DA9E9" opacity="0.18"/>
    <circle cx="770" cy="110" r="60" fill="#0F766E" opacity="0.15"/>
    <circle cx="760" cy="450" r="85" fill="#C48A00" opacity="0.14"/>
    <rect x="80" y="120" width="220" height="120" rx="22" fill="#FFFFFF" stroke="#2E6DA4" stroke-width="4"/>
    <text x="110" y="170" font-family="Arial" font-size="28" font-weight="700" fill="#163A5F">Teams Bot</text>
    <text x="110" y="208" font-family="Arial" font-size="18" fill="#475467">Slash commands</text>
    <text x="110" y="234" font-family="Arial" font-size="18" fill="#475467">Adaptive cards</text>
    <rect x="340" y="220" width="220" height="120" rx="22" fill="#FFFFFF" stroke="#0F766E" stroke-width="4"/>
    <text x="386" y="272" font-family="Arial" font-size="30" font-weight="700" fill="#0F766E">AI Engine</text>
    <text x="386" y="306" font-family="Arial" font-size="18" fill="#475467">Terse conversion</text>
    <rect x="600" y="120" width="220" height="120" rx="22" fill="#FFFFFF" stroke="#C48A00" stroke-width="4"/>
    <text x="642" y="170" font-family="Arial" font-size="28" font-weight="700" fill="#B45309">OneNote</text>
    <text x="635" y="208" font-family="Arial" font-size="18" fill="#475467">Executive-ready</text>
    <text x="645" y="234" font-family="Arial" font-size="18" fill="#475467">briefing output</text>
    <path d="M300 180 C360 180, 320 220, 360 240" stroke="#2E6DA4" stroke-width="8" fill="none" stroke-linecap="round"/>
    <path d="M560 240 C620 220, 590 180, 600 180" stroke="#0F766E" stroke-width="8" fill="none" stroke-linecap="round"/>
    <circle cx="360" cy="240" r="10" fill="#2E6DA4"/>
    <circle cx="600" cy="180" r="10" fill="#0F766E"/>
    <rect x="120" y="365" width="660" height="105" rx="22" fill="#163A5F"/>
    <text x="155" y="415" font-family="Arial" font-size="34" font-weight="700" fill="#FFFFFF">30 hours/week -> near-zero manual effort</text>
    <text x="155" y="450" font-family="Arial" font-size="20" fill="#DCEAF4">19 contributors, AI-assisted updates, no executive workflow disruption</text>
  </svg>`;
}

function painSvg() {
  return `
  <svg xmlns="http://www.w3.org/2000/svg" width="900" height="560" viewBox="0 0 900 560">
    <rect width="900" height="560" rx="28" fill="#EEF4F7"/>
    <rect x="90" y="90" width="220" height="320" rx="24" fill="#FFFFFF" stroke="#B45309" stroke-width="4"/>
    <rect x="340" y="90" width="220" height="320" rx="24" fill="#FFFFFF" stroke="#C48A00" stroke-width="4"/>
    <rect x="590" y="90" width="220" height="320" rx="24" fill="#FFFFFF" stroke="#2E6DA4" stroke-width="4"/>
    <text x="135" y="145" font-family="Arial" font-size="28" font-weight="700" fill="#B45309">Contributors</text>
    <text x="388" y="145" font-family="Arial" font-size="28" font-weight="700" fill="#C48A00">Jake</text>
    <text x="654" y="145" font-family="Arial" font-size="28" font-weight="700" fill="#2E6DA4">Will</text>
    <text x="120" y="205" font-family="Arial" font-size="20" fill="#475467">Copy-paste from</text>
    <text x="120" y="232" font-family="Arial" font-size="20" fill="#475467">old entries</text>
    <text x="120" y="280" font-family="Arial" font-size="20" fill="#475467">Blank-page anxiety</text>
    <text x="120" y="328" font-family="Arial" font-size="20" fill="#475467">Manual formatting</text>
    <text x="370" y="205" font-family="Arial" font-size="20" fill="#475467">Chasing 19 people</text>
    <text x="370" y="253" font-family="Arial" font-size="20" fill="#475467">Cleanup + reformatting</text>
    <text x="370" y="301" font-family="Arial" font-size="20" fill="#475467">No submission visibility</text>
    <text x="620" y="205" font-family="Arial" font-size="20" fill="#475467">Inconsistent inputs</text>
    <text x="620" y="253" font-family="Arial" font-size="20" fill="#475467">No trend visibility</text>
    <text x="620" y="301" font-family="Arial" font-size="20" fill="#475467">Late risk detection</text>
    <path d="M200 420 C260 470, 650 470, 700 420" stroke="#163A5F" stroke-width="12" fill="none" stroke-linecap="round"/>
    <circle cx="448" cy="470" r="42" fill="#163A5F"/>
    <text x="420" y="480" font-family="Arial" font-size="28" font-weight="700" fill="#FFFFFF">30h</text>
  </svg>`;
}

function solutionSvg() {
  return `
  <svg xmlns="http://www.w3.org/2000/svg" width="900" height="560" viewBox="0 0 900 560">
    <rect width="900" height="560" rx="28" fill="#EEF4F7"/>
    <rect x="70" y="170" width="210" height="180" rx="24" fill="#FFFFFF" stroke="#2E6DA4" stroke-width="4"/>
    <rect x="345" y="110" width="210" height="180" rx="24" fill="#FFFFFF" stroke="#0F766E" stroke-width="4"/>
    <rect x="620" y="170" width="210" height="180" rx="24" fill="#FFFFFF" stroke="#C48A00" stroke-width="4"/>
    <text x="115" y="225" font-family="Arial" font-size="26" font-weight="700" fill="#2E6DA4">Capture</text>
    <text x="105" y="260" font-family="Arial" font-size="18" fill="#475467">Teams slash command</text>
    <text x="105" y="286" font-family="Arial" font-size="18" fill="#475467">Adaptive card form</text>
    <text x="392" y="165" font-family="Arial" font-size="26" font-weight="700" fill="#0F766E">Process</text>
    <text x="382" y="200" font-family="Arial" font-size="18" fill="#475467">AI terse conversion</text>
    <text x="382" y="226" font-family="Arial" font-size="18" fill="#475467">Raw text archive</text>
    <text x="382" y="252" font-family="Arial" font-size="18" fill="#475467">Editable output</text>
    <text x="665" y="225" font-family="Arial" font-size="26" font-weight="700" fill="#B45309">Deliver</text>
    <text x="655" y="260" font-family="Arial" font-size="18" fill="#475467">Review dashboard</text>
    <text x="655" y="286" font-family="Arial" font-size="18" fill="#475467">OneNote integration</text>
    <path d="M280 260 L345 200" stroke="#2E6DA4" stroke-width="10" fill="none" stroke-linecap="round"/>
    <path d="M555 200 L620 260" stroke="#0F766E" stroke-width="10" fill="none" stroke-linecap="round"/>
    <circle cx="345" cy="200" r="9" fill="#2E6DA4"/>
    <circle cx="620" cy="260" r="9" fill="#0F766E"/>
    <rect x="150" y="400" width="600" height="82" rx="18" fill="#163A5F"/>
    <text x="185" y="449" font-family="Arial" font-size="28" font-weight="700" fill="#FFFFFF">Same executive endpoint, radically lower effort</text>
  </svg>`;
}

function personasSvg() {
  return `
  <svg xmlns="http://www.w3.org/2000/svg" width="900" height="560" viewBox="0 0 900 560">
    <rect width="900" height="560" rx="28" fill="#EEF4F7"/>
    ${[
      { x: 110, y: 140, color: "#2E6DA4", label: "Contributors" },
      { x: 320, y: 140, color: "#0F766E", label: "Jake" },
      { x: 530, y: 140, color: "#C48A00", label: "Will" },
      { x: 740, y: 140, color: "#B45309", label: "Leadership" },
    ].map(({ x, y, color, label }) => `
      <circle cx="${x}" cy="${y}" r="58" fill="${color}" opacity="0.92"/>
      <circle cx="${x}" cy="${y - 16}" r="19" fill="#FFFFFF"/>
      <path d="M ${x - 30} ${y + 34} Q ${x} ${y + 4} ${x + 30} ${y + 34}" fill="#FFFFFF"/>
      <text x="${x - 56}" y="${y + 102}" font-family="Arial" font-size="22" font-weight="700" fill="#163A5F">${esc(label)}</text>
    `).join("")}
    <path d="M168 308 C270 350, 630 350, 732 308" stroke="#163A5F" stroke-width="8" fill="none" stroke-dasharray="16 16"/>
    <text x="180" y="430" font-family="Arial" font-size="26" font-weight="700" fill="#163A5F">One system, four stakeholder experiences</text>
    <text x="180" y="465" font-family="Arial" font-size="20" fill="#475467">Capture for staff, orchestration for Jake, insight for Will, continuity for executives</text>
  </svg>`;
}

function journeySvg() {
  return `
  <svg xmlns="http://www.w3.org/2000/svg" width="900" height="560" viewBox="0 0 900 560">
    <rect width="900" height="560" rx="28" fill="#EEF4F7"/>
    <rect x="80" y="100" width="740" height="330" rx="26" fill="#FFFFFF" stroke="#DCEAF4" stroke-width="4"/>
    ${["Reminder","Capture","Compose","Submit","Review"].map((label, i) => {
      const x = 110 + i * 145;
      return `
      <circle cx="${x}" cy="220" r="34" fill="#2E6DA4"/>
      <text x="${x - 12}" y="228" font-family="Arial" font-size="22" font-weight="700" fill="#FFFFFF">${i + 1}</text>
      <text x="${x - 44}" y="300" font-family="Arial" font-size="18" font-weight="700" fill="#163A5F">${esc(label)}</text>
      ${i < 4 ? `<path d="M ${x + 34} 220 L ${x + 111} 220" stroke="#0F766E" stroke-width="8" stroke-linecap="round"/>` : ""}
      `;
    }).join("")}
    <text x="125" y="365" font-family="Arial" font-size="20" fill="#475467">Current: fragmented, manual, inconsistent</text>
    <text x="125" y="398" font-family="Arial" font-size="22" font-weight="700" fill="#0F766E">Future: prompted, structured, AI-polished, and reviewable</text>
  </svg>`;
}

function metricsSvg() {
  return `
  <svg xmlns="http://www.w3.org/2000/svg" width="900" height="560" viewBox="0 0 900 560">
    <rect width="900" height="560" rx="28" fill="#EEF4F7"/>
    <text x="110" y="120" font-family="Arial" font-size="22" font-weight="700" fill="#163A5F">Target impact</text>
    <rect x="120" y="170" width="150" height="220" rx="18" fill="#FFFFFF" stroke="#B45309" stroke-width="4"/>
    <rect x="315" y="120" width="150" height="270" rx="18" fill="#FFFFFF" stroke="#2E6DA4" stroke-width="4"/>
    <rect x="510" y="220" width="150" height="170" rx="18" fill="#FFFFFF" stroke="#0F766E" stroke-width="4"/>
    <rect x="705" y="145" width="150" height="245" rx="18" fill="#FFFFFF" stroke="#C48A00" stroke-width="4"/>
    <text x="148" y="425" font-family="Arial" font-size="18" fill="#475467">Admin hours</text>
    <text x="343" y="425" font-family="Arial" font-size="18" fill="#475467">Adoption</text>
    <text x="545" y="425" font-family="Arial" font-size="18" fill="#475467">Prep time</text>
    <text x="735" y="425" font-family="Arial" font-size="18" fill="#475467">On-time</text>
    <text x="155" y="462" font-family="Arial" font-size="28" font-weight="700" fill="#B45309">30 -> < 2</text>
    <text x="355" y="462" font-family="Arial" font-size="28" font-weight="700" fill="#2E6DA4">19 / 19</text>
    <text x="552" y="462" font-family="Arial" font-size="28" font-weight="700" fill="#0F766E">< 15 min</text>
    <text x="748" y="462" font-family="Arial" font-size="28" font-weight="700" fill="#C48A00">98%</text>
  </svg>`;
}

function scopeSvg() {
  return `
  <svg xmlns="http://www.w3.org/2000/svg" width="900" height="560" viewBox="0 0 900 560">
    <rect width="900" height="560" rx="28" fill="#EEF4F7"/>
    <rect x="105" y="120" width="690" height="320" rx="28" fill="#FFFFFF" stroke="#DCEAF4" stroke-width="4"/>
    <rect x="150" y="160" width="600" height="56" rx="16" fill="#163A5F"/>
    <text x="205" y="197" font-family="Arial" font-size="24" font-weight="700" fill="#FFFFFF">Cloud.gov foundation | Teams bot | AI workflow | OneNote integration</text>
    ${[
      [175, 255, '#2E6DA4', 'Foundation'],
      [380, 255, '#0F766E', 'Submission AI'],
      [585, 255, '#C48A00', 'Review + Output'],
    ].map(([x, y, c, label]) => `
      <rect x="${x}" y="${y}" width="145" height="110" rx="18" fill="#FFFFFF" stroke="${c}" stroke-width="4"/>
      <text x="${Number(x) + 20}" y="${Number(y) + 42}" font-family="Arial" font-size="22" font-weight="700" fill="${c}">${label}</text>
      <circle cx="${Number(x) + 72}" cy="${Number(y) + 75}" r="12" fill="${c}" opacity="0.9"/>
      <circle cx="${Number(x) + 52}" cy="${Number(y) + 75}" r="12" fill="${c}" opacity="0.55"/>
      <circle cx="${Number(x) + 92}" cy="${Number(y) + 75}" r="12" fill="${c}" opacity="0.35"/>
    `).join("")}
  </svg>`;
}

function roadmapSvg() {
  return `
  <svg xmlns="http://www.w3.org/2000/svg" width="900" height="560" viewBox="0 0 900 560">
    <rect width="900" height="560" rx="28" fill="#EEF4F7"/>
    <path d="M120 300 L780 300" stroke="#163A5F" stroke-width="10" stroke-linecap="round"/>
    ${[
      [150, '#2E6DA4', 'MVP'],
      [355, '#0F766E', 'Phase 2'],
      [560, '#C48A00', 'Phase 3'],
      [765, '#B45309', '2-3 Years'],
    ].map(([x, c, label]) => `
      <circle cx="${x}" cy="300" r="38" fill="${c}"/>
      <text x="${Number(x) - 42}" y="382" font-family="Arial" font-size="22" font-weight="700" fill="#163A5F">${label}</text>
    `).join("")}
    <text x="100" y="460" font-family="Arial" font-size="24" font-weight="700" fill="#163A5F">From workflow automation to predictive portfolio intelligence</text>
  </svg>`;
}

function closingSvg() {
  return `
  <svg xmlns="http://www.w3.org/2000/svg" width="900" height="560" viewBox="0 0 900 560">
    <defs>
      <linearGradient id="g" x1="0" y1="0" x2="1" y2="1">
        <stop offset="0%" stop-color="#163A5F"/>
        <stop offset="100%" stop-color="#2E6DA4"/>
      </linearGradient>
    </defs>
    <rect width="900" height="560" rx="28" fill="url(#g)"/>
    <circle cx="165" cy="165" r="70" fill="#FFFFFF" opacity="0.14"/>
    <circle cx="735" cy="410" r="88" fill="#FFFFFF" opacity="0.12"/>
    <text x="110" y="210" font-family="Arial" font-size="44" font-weight="700" fill="#FFFFFF">Why this wins</text>
    <text x="110" y="272" font-family="Arial" font-size="24" fill="#DCEAF4">Adoption-first contributor flow</text>
    <text x="110" y="314" font-family="Arial" font-size="24" fill="#DCEAF4">AI handles the formatting tax</text>
    <text x="110" y="356" font-family="Arial" font-size="24" fill="#DCEAF4">Leadership keeps the same OneNote endpoint</text>
    <rect x="108" y="410" width="520" height="78" rx="18" fill="#FFFFFF" opacity="0.16"/>
    <text x="136" y="458" font-family="Arial" font-size="28" font-weight="700" fill="#FFFFFF">Recover 28 hours/week for higher-value work</text>
  </svg>`;
}

function createSlides() {
  let slide = deck.addSlide("EPA_MASTER");
  slide.background = { color: colors.white };
  slide.addShape(deck.ShapeType.roundRect, {
    x: 0.55,
    y: 0.48,
    w: 7.1,
    h: 5.95,
    rectRadius: 0.08,
    fill: { color: colors.mist },
    line: { color: colors.ice, pt: 1 },
  });
  slide.addText("Product Brief", {
    x: 0.85,
    y: 0.88,
    w: 2.2,
    h: 0.32,
    fontFace: "Aptos",
    fontSize: 12,
    bold: true,
    color: colors.blue,
    margin: 0,
  });
  slide.addText("EPABusinessPlatform", {
    x: 0.85,
    y: 1.25,
    w: 5.8,
    h: 0.62,
    fontFace: "Aptos Display",
    fontSize: 28,
    bold: true,
    color: colors.ink,
    margin: 0,
  });
  slide.addText("Modernizing the Weekly Activity Report workflow with Teams-native capture, AI-powered terse conversion, and seamless OneNote delivery.", {
    x: 0.85,
    y: 1.95,
    w: 5.8,
    h: 0.62,
    fontFace: "Aptos",
    fontSize: 14,
    color: colors.slate,
    margin: 0,
    fit: "shrink",
  });
  addMetric(slide, 0.88, 3.08, 1.7, 1.1, "30 hrs", "manual work per week today", colors.coral);
  addMetric(slide, 2.82, 3.08, 1.7, 1.1, "19", "contributors in each cycle", colors.blue);
  addMetric(slide, 4.76, 3.08, 1.7, 1.1, "< 2 min", "target submission time", colors.green);
  slide.addText("Prepared from the February 9, 2026 product brief for ITSB leadership modernization planning.", {
    x: 0.88,
    y: 4.55,
    w: 5.9,
    h: 0.45,
    fontFace: "Aptos",
    fontSize: 11,
    color: colors.slate,
    margin: 0,
  });
  illustrationFrame(slide, "Concept image", "Workflow illustration embedded in the deck", heroSvg(), 7.95, 0.62, 4.75, 5.95);

  slide = deck.addSlide("EPA_MASTER");
  addTitle(slide, "Problem", "The current WAR process burns leadership time", "Three user groups absorb friction from the same broken manual workflow.");
  addCard(slide, 0.7, 2.05, 2.25, 2.2, "Contributors", "Copy-paste previous entries, navigate a growing OneNote, format by hand, and submit without reliable reminders.", colors.coral, colors.paleCoral);
  addCard(slide, 3.15, 2.05, 2.25, 2.2, "Jake", "Spends about 15 hours per week chasing non-respondents, reformatting updates, and assembling leadership-ready output.", colors.gold, colors.paleGold);
  addCard(slide, 5.6, 2.05, 2.25, 2.2, "Will", "Reviews inconsistent inputs, lacks historical trend visibility, and has no easy way to filter for the latest two-week window.", colors.blue, colors.mist);
  addBullets(slide, [
    "30 hours per week are consumed by manual administration.",
    "Formatting inconsistency reduces readability for senior management.",
    "Broken SharePoint automation left no dependable replacement path.",
    "Verbose submissions bury the small number of facts leaders actually need.",
  ], 0.8, 4.55, 7.0, 1.6, { fontSize: 13 });
  illustrationFrame(slide, "Pain map", "Current-state friction across contributors, aggregator, and reviewer", painSvg());

  slide = deck.addSlide("EPA_MASTER");
  addTitle(slide, "Solution", "A Teams-to-AI-to-OneNote operating model", "The product keeps executive consumption stable while modernizing everything upstream.");
  addBullets(slide, [
    "Frictionless capture: `/war` slash commands, adaptive cards, and pre-populated context reduce blank-page anxiety.",
    "Intelligent processing: AI converts verbose updates into terse executive-ready bullets while preserving raw detail.",
    "Seamless integration: Jake and Will review in the web app, then Microsoft Graph publishes to the existing OneNote workflow.",
  ], 0.75, 2.0, 6.9, 1.65, { fontSize: 13.5 });
  addCard(slide, 0.78, 4.0, 2.1, 1.55, "Differentiator", "Teams-native capture meets contributors where they already work.", colors.blue, colors.mist);
  addCard(slide, 3.0, 4.0, 2.1, 1.55, "Differentiator", "AI terse conversion removes manual editing from the critical path.", colors.green, colors.paleGreen);
  addCard(slide, 5.22, 4.0, 2.1, 1.55, "Differentiator", "OneNote remains the endpoint, so executive consumers see zero workflow disruption.", colors.gold, colors.paleGold);
  illustrationFrame(slide, "Operating model", "Capture, process, and deliver as a single controlled pipeline", solutionSvg());

  slide = deck.addSlide("EPA_MASTER");
  addTitle(slide, "Users", "Four audiences, one shared platform", "Each user experiences a different benefit, but the product succeeds only if all four do.");
  addCard(slide, 0.72, 1.95, 3.3, 1.35, "Contributors", "Need a fast submission flow inside Teams, with AI support and no blank-page friction.", colors.blue, colors.mist);
  addCard(slide, 0.72, 3.45, 3.3, 1.35, "Jake", "Needs visibility, automation, and elimination of the 'herding cats' burden.", colors.green, colors.paleGreen);
  addCard(slide, 4.28, 1.95, 3.3, 1.35, "Will", "Needs concise review views, date filters, and proactive issue detection.", colors.gold, colors.paleGold);
  addCard(slide, 4.28, 3.45, 3.3, 1.35, "Senior management", "Needs the same familiar OneNote consumption pattern with cleaner, more consistent content.", colors.coral, colors.paleCoral);
  illustrationFrame(slide, "Persona image", "Embedded illustration showing the platform's stakeholder map", personasSvg());

  slide = deck.addSlide("EPA_MASTER");
  addTitle(slide, "Journey", "The product replaces fragmented handoffs with a guided flow", "The strongest transformation is not new features; it is removing friction at every stage.");
  addBullets(slide, [
    "Reminder: Teams bot prompts instead of passive Outlook appointments.",
    "Capture: contributors stay inside Teams rather than opening an unwieldy OneNote.",
    "Composition: AI and structured prompts reduce rambling and formatting inconsistency.",
    "Submission: adaptive cards provide instant confirmation and structured intake.",
    "Review: Jake and Will work from filtered dashboards instead of copy-paste chains.",
  ], 0.75, 1.95, 6.95, 2.35, { fontSize: 13.25 });
  addCard(slide, 0.78, 4.6, 3.15, 1.2, "Contributor aha", "'I submitted my update without leaving Teams, and the AI made it sound professional.'", colors.blue, colors.mist);
  addCard(slide, 4.05, 4.6, 3.15, 1.2, "Aggregator aha", "'I went from 15 hours of manual work to reviewing an AI-generated briefing in 15 minutes.'", colors.green, colors.paleGreen);
  illustrationFrame(slide, "Journey image", "A five-stage transformation from reminder to review", journeySvg());

  slide = deck.addSlide("EPA_MASTER");
  addTitle(slide, "Metrics", "The business case is time, quality, and reliability", "The deck focuses on the measures that indicate actual operational change, not vanity metrics.");
  addMetric(slide, 0.75, 2.05, 1.9, 1.1, "30 -> < 2", "WAR admin hours per week", colors.coral);
  addMetric(slide, 2.9, 2.05, 1.9, 1.1, "19 / 19", "target active users per cycle", colors.blue);
  addMetric(slide, 5.05, 2.05, 1.9, 1.1, "98%", "on-time submission rate", colors.gold);
  addBullets(slide, [
    "Contributors: average submission time drops from 10-15 minutes to under 2 minutes.",
    "Jake: weekly WAR administration falls from about 15 hours to under 1 hour over time.",
    "Will: executive briefing prep drops from roughly 4 hours to under 15 minutes.",
    "System: target uptime exceeds 99.5% with OneNote integration reliability at 99%.",
  ], 0.8, 3.55, 6.95, 2.1, { fontSize: 13.2 });
  illustrationFrame(slide, "Metrics image", "Visual summary of the target operating improvements", metricsSvg());

  slide = deck.addSlide("EPA_MASTER");
  addTitle(slide, "MVP", "The minimum viable release is still a complete workflow", "The MVP is not just a form; it includes the end-to-end operating loop.");
  addBullets(slide, [
    "Platform foundation: Cloud.gov hosting, PostgreSQL, and user management for 19 contributors.",
    "AI-powered submission: Teams bot, terse conversion, raw archive, and editable pre-submission review.",
    "Review workflows: Jake and Will each get role-specific review and editing experiences.",
    "Notifications: scheduled reminders across email and Teams.",
    "Integration and output: Microsoft Graph prepends final content into senior management's OneNote.",
    "Admin and monitoring: usage metrics and noncompliance visibility.",
  ], 0.76, 1.95, 6.95, 2.95, { fontSize: 12.75 });
  addCard(slide, 0.82, 5.12, 3.2, 0.86, "Out of MVP", "Bullshit detector, predictive recommendations, voice-to-text, and advanced analytics move to later phases.", colors.coral, colors.paleCoral);
  addCard(slide, 4.1, 5.12, 3.2, 0.86, "MVP success", "100% contributor adoption, >90% Teams usage, <2 minute submissions, and zero executive workflow disruption.", colors.green, colors.paleGreen);
  illustrationFrame(slide, "Scope image", "Architecture-style illustration of the MVP layers", scopeSvg());

  slide = deck.addSlide("EPA_MASTER");
  addTitle(slide, "Roadmap", "The long-term vision expands from automation to intelligence", "Phase sequencing keeps the MVP focused while preserving a credible path to advanced analytics.");
  addCard(slide, 0.72, 2.0, 2.0, 2.0, "MVP", "Automate submission, review, reminders, and OneNote publication.", colors.blue, colors.mist);
  addCard(slide, 2.95, 2.0, 2.0, 2.0, "Phase 2", "Add AI stall detection, smart briefing generation, sentiment analysis, and natural-language query patterns.", colors.green, colors.paleGreen);
  addCard(slide, 5.18, 2.0, 2.0, 2.0, "Phase 3", "Expand into resource balancing, dependency visualization, and cross-team impact analysis.", colors.gold, colors.paleGold);
  addBullets(slide, [
    "2-3 year vision: multi-section EPA deployment and predictive portfolio management.",
    "Strategic expansion depends on nailing adoption, reliability, and time savings in the first release.",
  ], 0.78, 4.35, 6.9, 1.4, { fontSize: 13.2 });
  illustrationFrame(slide, "Roadmap image", "Timeline illustration for MVP through long-range vision", roadmapSvg());

  slide = deck.addSlide("EPA_MASTER");
  slide.background = { color: colors.white };
  slide.addImage({ data: svgDataUri(closingSvg()), x: 0.58, y: 0.62, w: 12.15, h: 5.9 });
  slide.addText("Critical success factors", {
    x: 0.88,
    y: 1.0,
    w: 3.0,
    h: 0.3,
    fontFace: "Aptos",
    fontSize: 12,
    bold: true,
    color: colors.white,
    margin: 0,
  });
  addBullets(slide, [
    "Adoption is everything: if contributors do not use it, the rest of the value chain never activates.",
    "AI must deliver: terse conversion is the core differentiator and cannot feel unreliable.",
    "OneNote integration must be invisible and dependable for senior management.",
    "The outcome is strategic time reallocation: about 28 hours per week returned to higher-value work.",
  ], 0.95, 3.05, 5.6, 2.05, { fontSize: 13, color: colors.white });
  slide.addText("Source: _bmad-output/planning-artifacts/product-brief-EPABusinessPlatform-2026-02-09.md", {
    x: 0.9,
    y: 5.95,
    w: 7.2,
    h: 0.28,
    fontFace: "Aptos",
    fontSize: 9.5,
    color: colors.white,
    margin: 0,
  });
}

async function main() {
  await fs.mkdir(outputDir, { recursive: true });
  createSlides();
  await deck.writeFile({ fileName: outputFile });
  console.log(`Created ${outputFile}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});