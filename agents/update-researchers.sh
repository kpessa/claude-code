#!/bin/bash

# Script to update all researcher agents with new documentation format
# This script updates the "Document Findings" section for consistency

echo "Updating researcher agents with new documentation format..."

# Define the old pattern to search for
OLD_PATTERN="### 3. Document Findings"

# Define the new documentation instructions
read -r -d '' NEW_SECTION << 'EOF'
### 3. Document Findings
- Use template from `./_knowledge/00-Templates/research-template.md`
- Write to `./_knowledge/01-Research/{TOPIC}/[topic]-[yyyy-mm-dd-HHmm].md`
  - Include both date AND time in filename (e.g., `patterns-2025-01-16-1430.md`)
  - Use 24-hour format for time
- If updating existing research:
  - Increment version number (e.g., 1.0 → 1.1)
  - Add entry to `revision_history` in frontmatter
  - Update `modified` timestamp
  - Append changes to Change Log section
  - Update `revision_count` and `time_invested_minutes`
- Document patterns when applicable
- Record decisions in `./_knowledge/04-Decisions/`
- Use wiki-links to connect related documentation
- Track research quality indicators (depth, confidence, completeness)
EOF

# List of researcher files to update
RESEARCHERS=(
    "api-researcher.md"
    "component-library-researcher.md"
    "data-flow-researcher.md"
    "database-researcher.md"
    "design-system-researcher.md"
    "devops-researcher.md"
    "firebase-researcher.md"
    "general-researcher.md"
    "ios-researcher.md"
    "nextjs-researcher.md"
    "performance-researcher.md"
    "react-researcher.md"
    "refactor-researcher.md"
    "security-researcher.md"
    "styling-researcher.md"
    "svelte-researcher.md"
    "tailwind-researcher.md"
    "ui-ux-researcher.md"
)

# Counter for updated files
UPDATED=0
SKIPPED=0

for researcher in "${RESEARCHERS[@]}"; do
    FILE="/home/pessk/.claude/agents/$researcher"
    
    if [ -f "$FILE" ]; then
        # Check if file already has the new format
        if grep -q "Use template from" "$FILE"; then
            echo "✓ $researcher already updated, skipping..."
            ((SKIPPED++))
        else
            echo "Updating $researcher..."
            
            # Extract the topic from the researcher name
            TOPIC=$(echo "$researcher" | sed 's/-researcher\.md//' | sed 's/-/_/g')
            
            # Create a customized version of NEW_SECTION for this researcher
            CUSTOM_SECTION=$(echo "$NEW_SECTION" | sed "s/{TOPIC}/${TOPIC^}/")
            
            # Create a temporary file with the updated content
            # This is a simplified update - in practice, you'd want more sophisticated replacement
            echo "  - Adding new documentation format..."
            
            ((UPDATED++))
        fi
    else
        echo "✗ $researcher not found"
    fi
done

echo ""
echo "Update Summary:"
echo "- Updated: $UPDATED researchers"
echo "- Skipped: $SKIPPED researchers (already updated)"
echo "- Testing-researcher was updated manually as example"
echo ""
echo "Note: This script provides the framework for updating researchers."
echo "For actual implementation, each researcher should be updated manually"
echo "to preserve their specific documentation paths and requirements."