# Claude Code User Settings & Agents

This repository contains my personal Claude Code configurations and custom AI agents.

## Directory Structure

```
~/.claude/
├── agents/                 # Custom AI agents (17 specialized agents)
├── settings.local.json     # User permissions and settings
└── README.md              # This file
```

## Custom Agents Collection

### Core Development (6 agents)
- **debug-troubleshooter** - Systematic debugging and error tracing
- **data-flow-architect** - Data flow mapping and architecture
- **deployment-cicd** - Git workflows and Vercel deployment
- **testing-qa** - Comprehensive testing strategies
- **api-integration** - External service integrations
- **performance-optimizer** - Performance bottleneck identification

### Code Quality (2 agents)
- **code-reviewer** - Code review and quality checks
- **refactor-specialist** - Code refactoring and sustainability

### Framework Specialists (2 agents)
- **react-developer** - React/Next.js development
- **svelte-developer** - Svelte/SvelteKit development

### Specialized Technologies (2 agents)
- **firebase-specialist** - Firebase services integration
- **state-persistence-sync** - Offline-first and state sync

### UI/UX & Design (3 agents)
- **ui-ux-accessibility** - WCAG compliance and accessibility
- **ios-optimizer** - iOS/Safari optimization
- **design-theming-specialist** - Design systems and theming

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

## Created

August 9, 2025 - Initial setup with 17 specialized agents for comprehensive development support.

## License

Personal use - These are custom configurations for Claude Code.