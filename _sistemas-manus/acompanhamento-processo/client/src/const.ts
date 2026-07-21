export { COOKIE_NAME, ONE_YEAR_MS } from "@shared/const";

// Return local login route instead of remote Manus OAuth URL
export const getLoginUrl = (returnPath?: string) => {
  return "/login";
};
