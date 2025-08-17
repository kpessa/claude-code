#!/bin/bash

# Initialize a project-level Obsidian knowledge vault
# Usage: ./init-knowledge-vault.sh [project-name]

PROJECT_NAME=${1:-$(basename "$PWD")}
KNOWLEDGE_DIR="_knowledge"

echo "🎯 Initializing Knowledge Vault for: $PROJECT_NAME"

# Create directory structure
echo "📁 Creating vault structure..."
mkdir -p "$KNOWLEDGE_DIR"/{00-Index/MOCs,01-Research/{Svelte,React,NextJS,Vue,Architecture,Styling,Components},02-Architecture,03-Components,04-Decisions,05-Dependencies,06-Performance,07-Security,08-Tech-Debt,09-Daily,attachments}

# Create .gitignore for Obsidian
echo "📝 Creating .gitignore for Obsidian..."
cat > "$KNOWLEDGE_DIR/.gitignore" << 'EOF'
# Obsidian
.obsidian/workspace*
.obsidian/cache
.trash/

# Keep all markdown files
!**/*.md
EOF

# Detect project type and frameworks
echo "🔍 Detecting project configuration..."
FRAMEWORK="unknown"
STYLING="unknown"
PACKAGE_MANAGER="unknown"

# Check for package.json
if [ -f "package.json" ]; then
    # Detect framework
    if grep -q '"svelte"' package.json || grep -q '"@sveltejs/kit"' package.json; then
        FRAMEWORK="svelte"
    elif grep -q '"next"' package.json; then
        FRAMEWORK="nextjs"
    elif grep -q '"react"' package.json; then
        FRAMEWORK="react"
    elif grep -q '"vue"' package.json; then
        FRAMEWORK="vue"
    fi
    
    # Detect styling
    if grep -q '"tailwindcss"' package.json; then
        STYLING="tailwind"
    fi
    
    # Detect package manager
    if [ -f "pnpm-lock.yaml" ]; then
        PACKAGE_MANAGER="pnpm"
    elif [ -f "yarn.lock" ]; then
        PACKAGE_MANAGER="yarn"
    elif [ -f "package-lock.json" ]; then
        PACKAGE_MANAGER="npm"
    elif [ -f "bun.lockb" ]; then
        PACKAGE_MANAGER="bun"
    fi
fi

# Create context.md
echo "📄 Creating context.md..."
cat > "$KNOWLEDGE_DIR/context.md" << EOF
---
tags: [project, context]
created: $(date +%Y-%m-%d)
updated: $(date +%Y-%m-%d)
---

# Project Context: $PROJECT_NAME

## Overview
[Project description and goals]

## Technology Stack
- **Framework**: $FRAMEWORK
- **Styling**: $STYLING
- **Package Manager**: $PACKAGE_MANAGER
- **Node Version**: $(node -v 2>/dev/null || echo "not detected")

## Project Structure
\`\`\`
$(tree -L 2 -I 'node_modules|.git|dist|build' 2>/dev/null || ls -la)
\`\`\`

## Architecture Decisions
- [[ADR-001 Framework Choice]]
- [[ADR-002 Styling Approach]]
- [[ADR-003 State Management]]

## Key Components
- Components documented in [[Components MOC]]
- API structure in [[API MOC]]
- Data flow in [[Data Flow]]

## Development Guidelines
- Code style: [ESLint/Prettier config]
- Git workflow: [branch strategy]
- Testing: [testing approach]

## Performance Targets
- Bundle size: [target]
- Load time: [target]
- Core Web Vitals: [targets]

## Dependencies
See [[Dependencies MOC]] for package analysis

## Technical Debt
Tracked in [[Tech Debt Overview]]

## Resources
- Repository: [URL]
- Documentation: [URL]
- Design files: [URL]

---
*Last Updated: $(date +%Y-%m-%d)*
EOF

# Create INDEX.md
echo "📄 Creating INDEX.md..."
cat > "$KNOWLEDGE_DIR/00-Index/INDEX.md" << 'EOF'
---
tags: [index, MOC, project]
created: DATE_PLACEHOLDER
updated: DATE_PLACEHOLDER
---

# 🏗️ Project Knowledge Base

## 🎯 Quick Navigation
- [[Architecture MOC]] - System architecture
- [[Components MOC]] - Component documentation
- [[API MOC]] - API structure
- [[Dependencies MOC]] - Package dependencies
- [[Tech Debt Overview]] - Technical debt tracking

## 📊 Project Metrics

### Codebase Overview
```dataview
TABLE WITHOUT ID
  type as "Type",
  count as "Files"
FROM ""
WHERE contains(file.path, "_knowledge")
GROUP BY type
```

### Recent Documentation
```dataview
TABLE 
  file.name as "Document",
  file.mtime as "Modified"
FROM ""
WHERE file.mtime > date(today) - dur(7 days)
SORT file.mtime DESC
LIMIT 10
```

## 🏗️ Architecture
- [[Component Tree]] - Visual component hierarchy
- [[Data Flow]] - State and data management
- [[API Structure]] - Endpoints and services
- [[Authentication Flow]] - Auth implementation

## 📦 Components
Recent component documentation:
```dataview
LIST
FROM "03-Components"
SORT file.mtime DESC
LIMIT 5
```

## 🎯 Architecture Decisions
```dataview
TABLE 
  status as "Status",
  date as "Date"
FROM "04-Decisions"
SORT date DESC
```

## 🔍 Code Analysis

### Technical Debt
```dataview
LIST
FROM "08-Tech-Debt"
WHERE priority = "high"
```

### Performance Issues
```dataview
LIST
FROM "06-Performance"
WHERE status = "unresolved"
```

### Security Concerns
```dataview
LIST
FROM "07-Security"
WHERE severity = "high"
```

## 📈 Project Health

### Test Coverage
- Unit Tests: [coverage%]
- Integration Tests: [status]
- E2E Tests: [status]

### Build Status
- Development: [status]
- Production: [status]
- Bundle Size: [size]

## 🔄 Recent Changes
```dataview
TABLE 
  file.name as "Document",
  agent as "Author",
  file.mtime as "Updated"
FROM "09-Daily"
SORT file.mtime DESC
LIMIT 7
```

## 🎯 Action Items
- [ ] Document main components
- [ ] Map data flow
- [ ] Create ADRs for key decisions
- [ ] Analyze dependencies
- [ ] Identify technical debt

## 📚 External Resources
- [Framework Documentation]
- [Design System]
- [API Documentation]

---
*This index updates automatically with Dataview queries*
EOF

# Replace date placeholders
sed -i '' "s/DATE_PLACEHOLDER/$(date +%Y-%m-%d)/g" "$KNOWLEDGE_DIR/00-Index/INDEX.md" 2>/dev/null || \
sed -i "s/DATE_PLACEHOLDER/$(date +%Y-%m-%d)/g" "$KNOWLEDGE_DIR/00-Index/INDEX.md"

# Create Architecture MOC
echo "📄 Creating Architecture MOC..."
cat > "$KNOWLEDGE_DIR/00-Index/MOCs/Architecture MOC.md" << 'EOF'
---
tags: [MOC, architecture]
created: DATE_PLACEHOLDER
---

# 🏗️ Architecture MOC

## System Overview
- [[System Architecture]]
- [[Technology Stack]]
- [[Infrastructure]]

## Data Architecture
- [[Data Flow]]
- [[State Management]]
- [[Database Schema]]
- [[API Structure]]

## Component Architecture
- [[Component Tree]]
- [[Component Patterns]]
- [[Shared Components]]

## Security Architecture
- [[Authentication Flow]]
- [[Authorization Model]]
- [[Security Policies]]

## Performance Architecture
- [[Caching Strategy]]
- [[Optimization Patterns]]
- [[Load Balancing]]

## Integration Points
- [[External APIs]]
- [[Third-party Services]]
- [[Webhooks]]

## Deployment Architecture
- [[CI/CD Pipeline]]
- [[Environment Configuration]]
- [[Monitoring Setup]]
EOF

# Create ADR template
echo "📄 Creating ADR template..."
cat > "$KNOWLEDGE_DIR/04-Decisions/ADR-template.md" << 'EOF'
---
tags: [ADR, decision]
date: DATE_PLACEHOLDER
status: proposed
---

# ADR-XXX: [Decision Title]

## Status
[Proposed | Accepted | Deprecated | Superseded]

## Context
What is the issue that we're seeing that is motivating this decision?

## Decision
What is the change that we're proposing and/or doing?

## Consequences
What becomes easier or more difficult to do because of this change?

### Positive
- 

### Negative
- 

### Neutral
- 

## Alternatives Considered
1. **Alternative 1**: Why not chosen
2. **Alternative 2**: Why not chosen

## References
- [[Related ADR]]
- [External Resource]
EOF

echo "✅ Knowledge Vault initialized successfully!"
echo ""
echo "📖 Next steps:"
echo "1. Open this folder in Obsidian: $PWD/$KNOWLEDGE_DIR"
echo "2. Install the Dataview plugin for dynamic queries"
echo "3. Start documenting with: context.md"
echo "4. Run research agents to populate the vault"
echo ""
echo "🎯 Quick tips:"
echo "- Use [[wiki links]] to connect concepts"
echo "- Tag with #framework/$FRAMEWORK #project"
echo "- Check the graph view to visualize connections"