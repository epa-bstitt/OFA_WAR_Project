// Shared settings store using file-based persistence
// In production, this would be a database

import { promises as fs } from "fs";
import { join } from "path";

const SETTINGS_FILE = join(process.cwd(), ".settings.json");

let memorySettings: Record<string, unknown> | null = null;

async function loadSettings(): Promise<Record<string, unknown>> {
  if (memorySettings) return memorySettings;
  
  try {
    const data = await fs.readFile(SETTINGS_FILE, "utf-8");
    memorySettings = JSON.parse(data);
    return memorySettings || {};
  } catch {
    // File doesn't exist or is corrupted
    return {};
  }
}

async function saveSettings(settings: Record<string, unknown>): Promise<void> {
  memorySettings = settings;
  try {
    await fs.writeFile(SETTINGS_FILE, JSON.stringify(settings, null, 2), "utf-8");
  } catch (err) {
    console.error("Failed to save settings:", err);
  }
}

export async function getStoredSettings(): Promise<Record<string, unknown>> {
  return loadSettings();
}

export async function setStoredSettings(settings: Record<string, unknown>): Promise<void> {
  const current = await loadSettings();
  const merged = { ...current, ...settings };
  
  // Deep merge for nested objects
  for (const key of Object.keys(settings)) {
    if (typeof settings[key] === "object" && !Array.isArray(settings[key])) {
      merged[key] = { ...(current[key] as object || {}), ...(settings[key] as object) };
    }
  }
  
  await saveSettings(merged);
}

export async function clearStoredSettings(): Promise<void> {
  memorySettings = {};
  try {
    await fs.unlink(SETTINGS_FILE);
  } catch {
    // File doesn't exist
  }
}
