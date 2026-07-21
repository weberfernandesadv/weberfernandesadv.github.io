import { COOKIE_NAME, ONE_YEAR_MS } from "@shared/const";
import type { Express, Request, Response } from "express";
import * as db from "../db";
import { getSessionCookieOptions } from "./cookies";
import { sdk } from "./sdk";

function getQueryParam(req: Request, key: string): string | undefined {
  const value = req.query[key];
  return typeof value === "string" ? value : undefined;
}

/**
 * Parses the OAuth state parameter.
 * Supports two formats:
 *   1. New format: base64(JSON { origin, returnPath })
 *   2. Legacy format: base64(redirectUri string) — kept for backward compatibility
 */
function parseState(state: string): { origin: string; returnPath: string } {
  try {
    const decoded = Buffer.from(state, "base64").toString("utf-8");

    // Try new JSON format first
    try {
      const parsed = JSON.parse(decoded);
      if (parsed && typeof parsed.origin === "string") {
        return {
          origin: parsed.origin,
          returnPath: typeof parsed.returnPath === "string" ? parsed.returnPath : "/",
        };
      }
    } catch {
      // Not JSON — fall through to legacy handling
    }

    // Legacy format: the decoded value was the full redirectUri (e.g. https://domain/api/oauth/callback)
    // Extract origin from it and default returnPath to "/"
    const url = new URL(decoded);
    return { origin: url.origin, returnPath: "/" };
  } catch {
    return { origin: "", returnPath: "/" };
  }
}

export function registerOAuthRoutes(app: Express) {
  app.get("/api/oauth/callback", async (req: Request, res: Response) => {
    const code = getQueryParam(req, "code");
    const state = getQueryParam(req, "state");

    if (!code || !state) {
      res.status(400).json({ error: "code and state are required" });
      return;
    }

    try {
      const tokenResponse = await sdk.exchangeCodeForToken(code, state);
      const userInfo = await sdk.getUserInfo(tokenResponse.accessToken);

      if (!userInfo.openId) {
        res.status(400).json({ error: "openId missing from user info" });
        return;
      }

      await db.upsertUser({
        openId: userInfo.openId,
        name: userInfo.name || null,
        email: userInfo.email ?? null,
        loginMethod: userInfo.loginMethod ?? userInfo.platform ?? null,
        lastSignedIn: new Date(),
      });

      const sessionToken = await sdk.createSessionToken(userInfo.openId, {
        name: userInfo.name || "",
        expiresInMs: ONE_YEAR_MS,
      });

      const cookieOptions = getSessionCookieOptions(req);
      res.cookie(COOKIE_NAME, sessionToken, { ...cookieOptions, maxAge: ONE_YEAR_MS });

      // Redirect to the returnPath (e.g. /admin) after successful login
      const { returnPath } = parseState(state);
      const safePath = returnPath.startsWith("/") ? returnPath : "/";
      res.redirect(302, safePath);
    } catch (error) {
      console.error("[OAuth] Callback failed", error);
      res.status(500).json({ error: "OAuth callback failed" });
    }
  });
}
