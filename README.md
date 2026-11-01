# Vera voice

**No interface, no problem.** Press the iPhone Action Button, say what you need, and an AI agent does the work and texts you back.

Vera is a personal project. This repo shows how the voice pipeline is put together. It contains no personal data and no knowledge base, only the design, example configuration and blank templates.

## Why it exists

Ideas die in the ten seconds it takes to unlock a phone, find an app and type. Most AI products answer that with one more app or one more gadget. Vera uses what is already in your hand, a button and a text thread.

## How it works

```
iPhone Action Button
  └─ Shortcut: dictate → send the transcript as an iMessage to yourself
        │
        ▼  iCloud syncs the message to the Mac
Mac (awake, logged in)
  └─ One long-lived Claude Code session, running inside a private notes folder
        ├─ iMessage channel plugin picks up the message
        ├─ Connectors reach calendar, email drafts, documents and the web
        ├─ Auto mode approves normal work, and a block list stops risky actions
        └─ Replies by iMessage with what it did
```

## What's in this repo

| Path | What it is |
|---|---|
| [`start-vera.command`](start-vera.command) | The launch loop. Keeps one session alive and resumes the same conversation after a crash or reboot |
| [`settings.example.json`](settings.example.json) | An example block list of actions the agent can never take |
| [`templates/CLAUDE.template.md`](templates/CLAUDE.template.md) | A blank operating manual for the agent |
| [`templates/kb-conventions.md`](templates/kb-conventions.md) | Rules for how a knowledge base stays organized |
| [`docs/shortcut.md`](docs/shortcut.md) | The iPhone Shortcut, step by step |
| [`docs/security.md`](docs/security.md) | The threat model and what this setup does not protect against |

There is not much code here, and that is the point. The agent is [Claude Code](https://code.claude.com/docs), and the iMessage connection is [Anthropic's official plugin](https://github.com/anthropics/claude-plugins-official/blob/main/external_plugins/imessage/README.md). What I designed is the way the pieces fit together, meaning the input path, the memory structure and the guardrails.

## Design decisions

| Problem | Decision |
|---|---|
| Opening an app is the friction | Input is one hardware button, and output is a normal text message |
| Permission prompts break a hands-free flow | Auto mode handles routine work, and hard block rules cover the dangerous cases |
| The agent stops to ask a multiple-choice question nobody can see | The question tool is blocked, so follow-ups arrive by text |
| A crash loses the conversation | The session has a fixed ID, so the loop resumes that exact session and not whichever one ran last |
| Other sessions could read Messages | The plugin is enabled only through this session's own settings file |
| Strangers could text the agent | It only listens to the self-chat, and SMS stays off because sender IDs can be spoofed |
| Dictation is messy | The manual lists common transcription errors and tells the agent to take the safest reasonable reading |

## Memory in three layers

Think of the agent as a consultant who works only for you.

| Layer | In the system | In the analogy | Does it fade? |
|---|---|---|---|
| Instructions | `CLAUDE.md`, read in full at every start | The briefing book they reread each morning | No |
| Conversation | The chat, compacted into summaries | Their memory of this week's meetings | Yes |
| Knowledge base | A folder of plain Markdown files, found through an index | The client library, exact and permanent | No |

Your consultant forgets meetings. Good ones write everything down.

A knowledge base might look like this, with folders that emerge from what you actually store.

```
my-kb/
├── CLAUDE.md
├── _index.md
├── _timeline.md
├── _changelog.md
├── kb-conventions.md
├── goals/
├── people/
├── plans/
├── projects/
└── sources/
```

## Status

| Capability | Status |
|---|---|
| Action Button to iMessage to agent, with a text reply | Working. Replies duplicate in the self-chat and don't trigger their own notification |
| Knowledge base and memory structure | Working, built by hand |
| Calendar, email drafts, documents and notes through connectors | Working in desktop sessions, not fully tested by voice |
| Works while the Mac is asleep or off | No |
| Works for other people without their own Mac setup | No, this is an idea |
| Proactive reminders and automatic onboarding | No, these are ideas |

## Try it yourself

You need a Mac with Messages signed in, an iPhone with an Action Button, [Claude Code](https://code.claude.com/docs), [Bun](https://bun.sh) and the iMessage plugin. Read [`docs/security.md`](docs/security.md) first, because this gives an agent real access to your accounts and files.

1. Keep your knowledge base in its own private folder, outside this repo.
2. Copy `settings.example.json` to `settings.json` and adjust the rules for your own connectors.
3. Fill in `templates/CLAUDE.template.md` and save it as `CLAUDE.md` in your knowledge base.
4. Grant Terminal Full Disk Access, which the plugin needs to read Messages. Understand what that allows before you do it.
5. Run `VERA_KB="$HOME/path/to/my-kb" ./start-vera.command`.
6. Build the [Shortcut](docs/shortcut.md) and assign it to the Action Button.

Channels are a research preview, so flags may change.

## Use of this repo

No license is granted. The repo is here to read and learn from. Claude Code and the iMessage plugin belong to Anthropic, and this project isn't affiliated with Anthropic or Apple.
