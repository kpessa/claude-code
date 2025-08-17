# Claude Code User Settings & Agents

This repository contains my centralized Claude Code configurations, custom AI agents, and global commands.

## Centralized Strategy

All agents and commands are maintained at the user level for consistency across all projects. See [CENTRALIZED-AGENTS.md](./CENTRALIZED-AGENTS.md) for details.

## Directory Structure

```
~/.claude/
├── agents/                 # Centralized AI agents (28 specialized agents)
│   ├── archived/          # Deprecated developer agents
│   └── *.md              # Active agents (research-first approach)
├── commands/              # Global slash commands
│   ├── pr-review.md      # GitHub PR review
│   ├── health-check.md   # Quick project health
│   ├── audit.md          # Comprehensive analysis
│   └── *.md              # Other commands
├── _knowledge/           # Centralized knowledge base
│   └── 01-Research/      # Research findings from agents
├── settings.json         # Global model assignments
├── settings.local.json   # User permissions
└── README.md            # This file
```

## Agent Categories (Research-First Approach)

### Research Agents (Haiku Model - 95% cost savings)
- **react-researcher** - React patterns and best practices
- **svelte-researcher** - Svelte/SvelteKit documentation
- **nextjs-researcher** - Next.js features and patterns
- **firebase-researcher** - Firebase service patterns
- **api-researcher** - API integration strategies
- **ui-ux-researcher** - UI/UX patterns and accessibility
- **styling-researcher** - CSS and styling strategies
- **tailwind-researcher** - Tailwind CSS patterns
- **component-library-researcher** - Component library analysis
- **design-system-researcher** - Design system patterns
- **database-researcher** - Database patterns and optimization
- **testing-researcher** - Testing strategies and patterns
- **security-researcher** - Security best practices
- **performance-researcher** - Performance optimization patterns
- **ios-researcher** - iOS/Safari optimization research
- **refactor-researcher** - Code quality and refactoring analysis
- **general-researcher** - General purpose research

### Knowledge Management (Haiku Model)
- **knowledge-curator** - Organizes research findings
- **codebase-analyst** - Analyzes code structure

### Critical Reasoning (Opus Model)
- **knowledge-synthesizer** - Complex reasoning and synthesis
- **code-reviewer** - Code quality and security review
- **debug-troubleshooter** - Complex problem solving

### Development Support (Haiku Model)
- **testing-qa** - Test implementation
- **deployment-cicd** - Deployment and CI/CD
- **performance-optimizer** - Performance tuning
- **state-persistence-sync** - State management

### Archived (Moved to research-only)
- Located in `agents/archived/`
- Developer agents with Edit/MultiEdit capabilities
- Replaced by research + main thread approach

## Usage

To use an agent in Claude Code:

```javascript
Task(subagent_type="agent-name", prompt="Your task description")
```

Example:
```javascript
Task(subagent_type="debug-troubleshooter", prompt="Find why component isn't updating")
```

## Agent Capabilities

Each agent has specialized knowledge and tools:
- Specific domain expertise
- Curated tool access (Read, Edit, Bash, etc.)
- Detailed system prompts for consistent behavior
- Best practices and patterns for their domain

## Setup

1. These agents are automatically available in Claude Code at the user level
2. They work across all your projects
3. No additional configuration needed

## Contributing

To add a new agent:
1. Create a new `.md` file in the `agents/` directory
2. Use the following format:

```markdown
---
name: agent-name
description: Brief description of agent's purpose
tools: Read, Edit, Grep, Glob, Bash
---

[System prompt content here]
```

## Backup

This repository serves as a backup of all custom Claude Code configurations. To restore:

1. Clone this repository to `~/.claude/`
2. Restart Claude Code

## Updates

- August 17, 2025 - Centralized all agents at user level, research-first approach
- August 16, 2025 - Optimized models (Haiku for research, Opus for critical)
- August 9, 2025 - Initial setup with specialized agents

## License

Personal use - These are custom configurations for Claude Code.