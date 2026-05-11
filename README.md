# WeMemory

**Shared, persistent memory for AI-powered teams.**

AI agents today create knowledge silos — each only knows what its individual user has shared. WeMemory is persistent, shared memory across your entire company: every session, meeting, and document compounds into context that makes each new AI interaction as informed as if it'd been there for every conversation.

## The Problem

A single person with AI agents can run an entire company. But the moment a second person joins, context breaks. Each agent only knows what its user told it. Meetings produce transcripts nobody re-reads. Documents aren't indexed. Decisions made in one session are invisible to the next.

The result: **knowledge silos that grow with every interaction**, repeated context, contradicted decisions, and lost institutional memory.

## What WeMemory Does

WeMemory creates a **persistent, shared knowledge base** for your entire organization. Every piece of work — AI coding sessions, meetings, documents, decisions — is automatically captured, structured, and semantically indexed.

The key insight: **every new AI interaction starts with full context** built from everything the company has ever produced. Agents don't just know what you told them — they know what everyone knows.

## How It Works

1. **Capture** — AI sessions are automatically summarized. Meetings are transcribed and structured. Documents are analyzed and indexed.
2. **Structure** — Decisions, open questions, and next steps are extracted automatically. Knowledge items are versioned with lifecycle management.
3. **Retrieve** — At the start of each new session, semantic search surfaces relevant context from the entire knowledge base. The agent receives shared memory before you type a single word.
4. **Compound** — Every interaction makes the next one smarter. Context accumulates across people, projects, and time.

## Features

- **Automatic AI Session Capture** — Every coding session generates a structured summary (decisions, open questions, next steps) pushed to the shared knowledge base
- **Intelligent Session Context** — Semantic search at session start provides relevant context from past sessions across the entire team
- **Meeting Ingestion** — Transcripts from Google Meet (via Gemini) or any source are automatically structured and stored
- **File Scanning & Summarization** — Uploaded files are analyzed by AI, summarized, and semantically indexed
- **Semantic Search** — Vector search (Voyage AI + pgvector) across sessions, knowledge, and files — find anything by meaning
- **Knowledge Lifecycle** — Durable decisions and conventions with supersession and versioning
- **Auto-Update** — Client self-updates on every launch via a release system with SHA256 verification
- **Integrations** — Google Meet, Google Drive, Gmail, Telegram bot, Claude Code

## Installation

```bash
git clone https://github.com/legasicrypto/we-memory.git
cd we-memory
bash install.sh
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc
```

### Configuration

Set your API URL (provided by your admin):

```bash
export LEGASI_API_URL="https://your-instance.example.com"
```

Authenticate:

```bash
legasi-login
```

## Commands

| Command | Description |
|---------|-------------|
| `legasi-session` | Launch an AI coding session with auto-capture |
| `legasi-push` | Push a session summary to the shared memory |
| `legasi-query smart "query"` | Semantic search across all knowledge |
| `legasi-query search "query"` | Text search (keyword matching) |
| `legasi-query sessions <project>` | List sessions by project |
| `legasi-query knowledge <project>` | List knowledge items by project |
| `legasi-knowledge <project> <title> <content>` | Create a knowledge item |
| `legasi-knowledge-interactive` | Interactive knowledge item creation |
| `legasi-upload <file> <project>` | Upload a file |
| `legasi-ingest --file transcript.txt` | Ingest a meeting transcript |
| `legasi-login` | Authenticate with the API |

## API Reference

Base URL: `https://your-instance.example.com`

All endpoints require `X-API-Key` header (except health check and file downloads).

### Sessions

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/session-note` | Create a session note |
| `GET` | `/sessions/{project}` | List sessions by project |
| `DELETE` | `/sessions/{id}` | Delete a session |

**Session Note Schema:**

```json
{
  "project": "engineering",
  "author": "user@company.com",
  "summary": "2-5 sentence summary of what was accomplished",
  "decisions": ["Key decision 1", "Key decision 2"],
  "open_questions": ["Unresolved question"],
  "next_steps": ["Concrete next action"],
  "files_modified": ["path/to/file.ts"],
  "commits": ["abc1234"],
  "tags": ["dev", "feature"],
  "scope": "project"
}
```

- `scope`: `personal` | `project` | `company`
- Duplicate detection: returns `409 Conflict` when embedding similarity >= 0.95

### Knowledge Items

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/knowledge-item` | Create a knowledge item |
| `GET` | `/knowledge/{project}` | List knowledge items (add `?include_inactive=true` for superseded items) |
| `DELETE` | `/knowledge/{id}` | Delete a knowledge item |
| `POST` | `/knowledge/{id}/supersede` | Replace a knowledge item with a newer one |

Key decisions from sessions are automatically extracted as knowledge items.

### Search

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/semantic-search?q={query}&limit={n}&project={slug}` | Semantic search (vector-based, recommended) |
| `GET` | `/search?q={query}` | Text search (keyword matching) |

### Files

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/upload` | Upload a file (multipart form) |
| `GET` | `/files?project={slug}` | List files |
| `GET` | `/files/{uuid}` | Download a file |
| `DELETE` | `/files/{uuid}` | Delete a file |

### Transcripts

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/ingest-transcript` | Ingest and structure a meeting transcript |

### Administration

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/health` | Health check (no auth required) |
| `GET` | `/projects` | List all projects |
| `GET` | `/members` | List all team members |

## Stack

- **Client**: Bash, Python stdlib (zero external dependencies)
- **Server**: FastAPI, PostgreSQL 16, pgvector, Voyage AI, Claude API
- **Infrastructure**: nginx, systemd, Let's Encrypt (HTTPS)
- **Integrations**: Google Apps Script (Meet/Drive/Gmail), Telegram bot

## License

All rights reserved. See [LICENSE](LICENSE) for details.
