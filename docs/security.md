# Security

This setup gives an AI agent real access to your files and accounts, and it runs without approval prompts for routine work. Treat it as an experiment, and don't assume the example configuration makes it safe.

## What the design does

- **Keeps the knowledge base private.** It lives in its own folder, outside this repo, and should never be committed to a public repo. The launch script refuses to run if the folder is inside this one.
- **Limits who can give instructions.** The channel listens only to the self-chat, and SMS stays off because sender IDs can be spoofed.
- **Treats outside content as data.** The manual tells the agent that text in web pages, emails and documents is never an instruction.
- **Blocks irreversible actions.** Deny rules apply in every permission mode. Email stays as drafts, and nothing gets deleted or shared.
- **Scopes the plugin.** The iMessage plugin is enabled only through this session's settings file.

## What it does not protect against

- **Prompt injection.** Anyone can send you an email or publish a page with text designed to steer the agent. Auto mode and the block list reduce that risk, but neither removes it.
- **Shell workarounds.** `Read` rules cover the built-in file tool and may not stop a shell command from reading the same file. A block list is not a sandbox, and a blocked command may have an alternative. For real isolation, run the agent under a separate macOS user or in a sandbox.
- **Full Disk Access.** The plugin needs it to read Messages, and it applies to Terminal as a whole.
- **Calendar invites.** A deny rule can't stop an event from inviting attendees, so this is covered only by an instruction in the manual.
- **Physical or account access.** Anyone with your unlocked Mac, your Apple ID or your iPhone can reach the agent.
- **Third parties.** Dictation services, Apple and the model provider all process what you say.

## Before you publish a fork

- Keep your filled-in `CLAUDE.md`, `settings.json`, `session-id` and logs out of the repo.
- Check that your git history doesn't contain any of them, and that your commit email is the one you want public.
- Don't publish your live configuration, because it tells people exactly what isn't blocked.
