# Wemory

**Shared, persistent memory for AI-powered teams.**

Every AI interaction your team has — coding sessions, meetings, documents, decisions — creates knowledge that disappears the moment the session ends. Wemory captures it all and makes it available to every future interaction, for everyone on the team.

The result: AI agents that know what the entire company knows.

## The Problem

One person with AI can run an entire company. But with two people, context breaks. Each agent only knows what its own user told it. Meetings produce transcripts nobody re-reads. Decisions made in one session are invisible to the next.

**Knowledge silos grow with every interaction.** Context gets repeated. Decisions get contradicted. Institutional memory is lost.

## What Wemory Does

Wemory gives your team a **collective memory layer** that sits between your people and their AI agents. Every piece of work is automatically captured, structured, and made retrievable — so each new interaction starts with the full picture, not a blank slate.

- A developer starts a coding session and immediately has context from every past session on the topic — across the whole team
- A meeting ends and its decisions, action items, and context are already searchable by everyone's AI agents
- A document is uploaded and its key information becomes part of the shared knowledge, instantly
- A decision made three months ago surfaces automatically when it's relevant again

The more your team uses AI, the smarter every interaction gets.

## Capabilities

### AI Session Memory
Every AI coding session is automatically captured as a structured summary. Decisions, open questions, and next steps are extracted and become part of the shared knowledge base. When anyone starts a new session, relevant context from past work is automatically surfaced.

### Meeting Intelligence
Meeting transcripts — from Google Meet, or any other source — are ingested, structured, and indexed. Participants, decisions, and follow-ups are extracted automatically. No manual note-taking, no lost context.

### Document & File Intelligence
Upload any document, codebase, or file. Wemory analyzes and indexes it so the content becomes searchable by meaning — not just keywords.

### Semantic Search
Find anything by meaning. Ask a question in natural language, and Wemory surfaces the most relevant sessions, knowledge, and files — even if the exact words don't match.

### Knowledge Lifecycle
Important decisions and conventions are captured as durable knowledge items. As things evolve, knowledge can be versioned, superseded, or retired — so your memory stays current, not cluttered.

### Integrations
- **Claude Code** — Native integration for AI coding sessions
- **Google Workspace** — Automatic ingestion from Google Meet, Drive, and Gmail
- **Telegram** — Query the shared memory directly from your team chat
- **API** — RESTful API for custom integrations

### Zero-Friction Deployment
Install in one command. The client self-updates automatically. Zero external dependencies beyond bash, curl, and python3.

## Getting Started

```bash
git clone https://github.com/legasicrypto/we-memory.git
cd we-memory
bash install.sh
```

Then authenticate:

```bash
wemory-login
```

## Quick Reference

| Command | What it does |
|---------|--------------|
| `wemory-session` | Start an AI session with shared memory |
| `wemory-push` | Push a session summary |
| `wemory-query smart "your question"` | Search by meaning |
| `wemory-query search "keyword"` | Search by keyword |
| `wemory-query sessions <project>` | Browse sessions |
| `wemory-query knowledge <project>` | Browse knowledge items |
| `wemory-knowledge <project> <title> <content>` | Add a knowledge item |
| `wemory-upload <file> <project>` | Upload a file |
| `wemory-ingest --file transcript.txt` | Ingest a meeting transcript |

## License

All rights reserved. See [LICENSE](LICENSE) for details.
