/**
 * tmux-agent-status
 *
 * Reports this pi session's lifecycle state to a small JSON file so the
 * `pi-agent-sidebar` tmux script can list every running pi agent with a
 * status icon (idle / working / needs a prompt) across all sessions/windows.
 *
 * No-ops entirely when not running inside tmux.
 */
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { mkdirSync, writeFileSync, rmSync } from "node:fs";
import { join } from "node:path";

const paneId = process.env.TMUX_PANE;

export default function (pi: ExtensionAPI) {
  if (!paneId) return; // not inside tmux, nothing to report

  const dir = join(
    process.env.XDG_CACHE_HOME || join(process.env.HOME || "/tmp", ".cache"),
    "pi-agent-sidebar",
  );
  const file = join(dir, `${paneId.replace("%", "p")}.json`);

  let status: "ready" | "working" = "ready";

  const write = () => {
    try {
      mkdirSync(dir, { recursive: true });
      writeFileSync(
        file,
        JSON.stringify({
          status,
          cwd: process.cwd(),
          name: pi.getSessionName(),
          updated: Date.now(),
        }),
      );
    } catch {
      // best effort, sidebar just won't show this pane
    }
  };

  pi.on("session_start", async () => {
    status = "ready";
    write();
  });
  pi.on("before_agent_start", async () => {
    status = "working";
    write();
  });
  pi.on("agent_settled", async () => {
    status = "ready";
    write();
  });
  pi.on("session_info_changed", async () => write());
  pi.on("session_shutdown", async () => {
    try {
      rmSync(file, { force: true });
    } catch {
      // ignore
    }
  });
}
