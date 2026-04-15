export function isEnhancedContractSubmissionsEnabled(): boolean {
  return process.env.ENABLE_ENHANCED_CONTRACT_SUBMISSIONS !== "false";
}