/**
 * auto-session-name
 *
 * Names the session from an LLM-generated summary of the conversation so
 * far, refreshed at the end of every turn, so the /resume picker shows a
 * meaningful title instead of raw text.
 */
import { complete } from "@earendil-works/pi-ai/compat";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

const textOf = (content: unknown): string =>
  typeof content === "string"
    ? content
    : Array.isArray(content)
      ? content
          .filter((c): c is { type: "text"; text: string } => c.type === "text")
          .map((c) => c.text)
          .join(" ")
      : "";

export default function (pi: ExtensionAPI) {
  pi.on("turn_end", async (_event, ctx) => {
    const conversation = ctx.sessionManager
      .getEntries()
      .filter((e) => e.type === "message" && (e.message.role === "user" || e.message.role === "assistant"))
      .map((e) => e.type === "message" && `${e.message.role}: ${textOf(e.message.content)}`)
      .filter(Boolean)
      .join("\n");
    if (!conversation.trim()) return;

    const auth = await ctx.modelRegistry.getApiKeyAndHeaders(ctx.model);
    if (!auth.ok || !auth.apiKey) return; // no key configured, skip silently

    const response = await complete(
      ctx.model,
      {
        messages: [
          {
            role: "user",
            content: [
              {
                type: "text",
                text: `Summarize this conversation as a session title, 6 words max, no punctuation or quotes:\n\n${conversation.slice(0, 4000)}`,
              },
            ],
            timestamp: Date.now(),
          },
        ],
      },
      { apiKey: auth.apiKey, headers: auth.headers, env: auth.env, cacheRetention: "none" },
    );

    const title = response.content
      .filter((c): c is { type: "text"; text: string } => c.type === "text")
      .map((c) => c.text)
      .join(" ")
      .trim();
    if (title) pi.setSessionName(title.slice(0, 60));
  });
}
