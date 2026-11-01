# Knowledge base conventions

The philosophy for how information gets stored, named, tagged, consolidated and retrieved. Read this before restructuring anything.

## Core philosophy

- **Structure follows content.** Let categories emerge from what's actually been written down.
- **Bias toward consolidation.** A new topic starts in an existing, related file and earns its own file once that file gets unwieldy.
- **Everything is findable two ways.** Folder location gets you close, and frontmatter tags get you exact.

## Reorganization policy

**Do without asking:** fix names to match the convention, merge obvious duplicates, repair frontmatter and tidy within a file.

**Ask first:** move content between top-level folders, split a file, delete anything, change more than about two files at once, or add a top-level folder.

Log every change in `_changelog.md`, newest first.

## When to split a file

- It covers distinct topics that aren't referenced together.
- It has grown long enough that finding something is slow.
- A subtopic keeps getting its own recurring updates.

Leave a one-line pointer in the original file so old references don't dead-end.

## Naming

- Files and folders use lowercase `kebab-case.md`.
- Dates in filenames use `YYYY-MM-DD`.
- Prefer descriptive names, such as `kitchen-remodel.md` over `project-3.md`.
- `CLAUDE.md`, `README.md` and underscore-prefixed index files are exempt.

## Frontmatter

```markdown
---
tags: [finance, monthly]
created: 2026-01-15
updated: 2026-01-15
---
```

Reuse existing tags from the registry in `_index.md` before inventing new ones. Bump `updated` on meaningful edits.

## Sources and derived notes

- Raw inputs are saved unedited in `sources/` and listed in a manifest. Never edit a source.
- Derived notes keep facts, in quotes with dates, separate from interpretation.
- One fact lives in one canonical place, and other notes link to it.

## Cleanup

Periodically review for stale content, duplicates and drifting tags. Prefer archiving to deleting.

## Sensitive information

Never store account numbers, government IDs, passwords or other credentials here, even though the folder is private.

## Retrieval

Check the most specific relevant file first. If an answer might span categories, pull from each rather than guessing.
