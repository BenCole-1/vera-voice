#!/bin/zsh
# Vera voice session: an always-on Claude Code session in your knowledge base,
# fed by the iMessage channel. Restarts itself if it exits.
# Runs in auto mode with the block list in settings.json (next to this script).
#
# Usage: VERA_KB="$HOME/path/to/my-kb" ./start-vera.command

export PATH="$HOME/.local/bin:$HOME/.bun/bin:$PATH"
VERA="${VERA_KB:?Set VERA_KB to your knowledge base folder}"
VV="$(cd "$(dirname "$0")" && pwd)"   # this script's own folder, wherever it lives

[[ -f "$VV/settings.json" ]] || { echo "Copy settings.example.json to settings.json first"; exit 1; }
[[ "${VERA:A}" == "$VV"* ]] && { echo "Keep your knowledge base outside this repo"; exit 1; }

# session-id is gitignored. It pins this loop to one conversation.
[[ -f "$VV/session-id" ]] || uuidgen | tr A-Z a-z > "$VV/session-id"
SID="$(cat "$VV/session-id")"

cd "$VERA" || exit 1
TRANSCRIPT="$HOME/.claude/projects/${PWD//[^A-Za-z0-9]/-}/$SID.jsonl"

while true; do
  if [[ -f "$TRANSCRIPT" ]]; then
    SESSION_ARGS=(--resume "$SID")      # pick up the same conversation
  else
    SESSION_ARGS=(--session-id "$SID")  # first run: create it with a fixed ID
  fi

  claude "${SESSION_ARGS[@]}" \
    --permission-mode auto \
    --settings "$VV/settings.json" \
    --channels plugin:imessage@claude-plugins-official \
    --remote-control "Vera (voice)"

  echo "$(date '+%Y-%m-%d %H:%M:%S') Vera session exited; restarting in 10s" >> "$VV/restarts.log"
  sleep 10
done
