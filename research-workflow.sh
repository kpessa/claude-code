#!/bin/bash

# Research-First Development Workflow Script
# Orchestrates the vision → research → planning → implementation workflow

set -e

KNOWLEDGE_DIR="_knowledge"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[$(date +%H:%M:%S)]${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Function to check if knowledge vault exists
check_knowledge_vault() {
    if [ ! -d "$KNOWLEDGE_DIR" ]; then
        print_warning "Knowledge vault not found. Initializing..."
        "$SCRIPT_DIR/init-knowledge-vault.sh"
    else
        print_success "Knowledge vault found at $KNOWLEDGE_DIR"
    fi
}

# Function to create vision document
create_vision() {
    local project_name="${1:-Project}"
    local vision_file="$KNOWLEDGE_DIR/00-Vision/vision.md"
    
    mkdir -p "$KNOWLEDGE_DIR/00-Vision"
    
    if [ -f "$vision_file" ]; then
        print_warning "Vision file already exists. Opening for editing..."
    else
        print_status "Creating vision document..."
        cp "$SCRIPT_DIR/vision-template.md" "$vision_file"
        sed -i '' "s/{{Project Name}}/$project_name/g" "$vision_file" 2>/dev/null || \
        sed -i "s/{{Project Name}}/$project_name/g" "$vision_file"
        sed -i '' "s/{{date}}/$(date +%Y-%m-%d)/g" "$vision_file" 2>/dev/null || \
        sed -i "s/{{date}}/$(date +%Y-%m-%d)/g" "$vision_file"
        print_success "Vision template created at $vision_file"
    fi
    
    echo ""
    echo "Please edit the vision file to define:"
    echo "  - Primary goals and objectives"
    echo "  - Success criteria"
    echo "  - Constraints and requirements"
    echo "  - Key research questions"
    echo ""
    echo "File: $vision_file"
}

# Function to trigger research phase
start_research() {
    print_status "Starting research phase..."
    
    if [ ! -f "$KNOWLEDGE_DIR/00-Vision/vision.md" ]; then
        print_error "Vision document not found. Please create vision first."
        exit 1
    fi
    
    # Update context.md to research phase
    update_phase "research"
    
    print_status "Research agents will investigate:"
    echo "  - Technology options"
    echo "  - Architecture patterns"
    echo "  - Implementation approaches"
    echo "  - Best practices"
    echo ""
    echo "Run research with: claude 'Research the vision in .knowledge/00-Vision/vision.md'"
}

# Function to generate implementation plan
generate_plan() {
    print_status "Generating implementation plan..."
    
    local plan_file="$KNOWLEDGE_DIR/02-Planning/implementation-plan.md"
    mkdir -p "$KNOWLEDGE_DIR/02-Planning"
    
    if [ -f "$plan_file" ]; then
        print_warning "Implementation plan already exists."
    else
        cp "$SCRIPT_DIR/implementation-plan-template.md" "$plan_file"
        sed -i '' "s/{{date}}/$(date +%Y-%m-%d)/g" "$plan_file" 2>/dev/null || \
        sed -i "s/{{date}}/$(date +%Y-%m-%d)/g" "$plan_file"
        print_success "Plan template created at $plan_file"
    fi
    
    # Update context.md to planning phase
    update_phase "planning"
    
    echo ""
    echo "Generate plan with: claude 'Create implementation plan based on research'"
}

# Function to start implementation
start_implementation() {
    print_status "Starting implementation phase..."
    
    if [ ! -f "$KNOWLEDGE_DIR/02-Planning/implementation-plan.md" ]; then
        print_error "Implementation plan not found. Please create plan first."
        exit 1
    fi
    
    # Update context.md to implementation phase
    update_phase "implementation"
    
    print_success "Implementation phase started"
    echo "Developers can now reference:"
    echo "  - Vision: $KNOWLEDGE_DIR/00-Vision/vision.md"
    echo "  - Plan: $KNOWLEDGE_DIR/02-Planning/implementation-plan.md"
    echo "  - Research: $KNOWLEDGE_DIR/01-Research/"
}

# Function to update phase in context.md
update_phase() {
    local new_phase="$1"
    local context_file="$KNOWLEDGE_DIR/context.md"
    
    if [ -f "$context_file" ]; then
        # Update phase line
        sed -i '' "s/^phase: .*/phase: $new_phase/g" "$context_file" 2>/dev/null || \
        sed -i "s/^phase: .*/phase: $new_phase/g" "$context_file"
        
        # Update updated date
        sed -i '' "s/^updated: .*/updated: $(date +%Y-%m-%d)/g" "$context_file" 2>/dev/null || \
        sed -i "s/^updated: .*/updated: $(date +%Y-%m-%d)/g" "$context_file"
        
        print_success "Updated context.md to phase: $new_phase"
    else
        print_warning "context.md not found"
    fi
}

# Function to check current status
check_status() {
    print_status "Checking project status..."
    echo ""
    
    # Check vision
    if [ -f "$KNOWLEDGE_DIR/00-Vision/vision.md" ]; then
        print_success "Vision: Created"
    else
        print_error "Vision: Not created"
    fi
    
    # Check research
    research_count=$(find "$KNOWLEDGE_DIR/01-Research" -name "*.md" 2>/dev/null | wc -l)
    if [ "$research_count" -gt 0 ]; then
        print_success "Research: $research_count documents"
    else
        print_warning "Research: No documents yet"
    fi
    
    # Check plan
    if [ -f "$KNOWLEDGE_DIR/02-Planning/implementation-plan.md" ]; then
        print_success "Plan: Created"
    else
        print_error "Plan: Not created"
    fi
    
    # Check current phase from context.md
    if [ -f "$KNOWLEDGE_DIR/context.md" ]; then
        current_phase=$(grep "^phase:" "$KNOWLEDGE_DIR/context.md" | cut -d' ' -f2)
        echo ""
        echo "Current Phase: ${current_phase:-unknown}"
    fi
    
    # Check ADRs
    adr_count=$(find "$KNOWLEDGE_DIR/04-Decisions" -name "ADR-*.md" 2>/dev/null | wc -l)
    if [ "$adr_count" -gt 0 ]; then
        echo "Decisions: $adr_count ADRs"
    fi
}

# Function to show help
show_help() {
    echo "Research-First Development Workflow"
    echo ""
    echo "Usage: $0 [command] [options]"
    echo ""
    echo "Commands:"
    echo "  init [name]     Initialize knowledge vault for project"
    echo "  vision [name]   Create vision document"
    echo "  research        Start research phase"
    echo "  plan            Generate implementation plan"
    echo "  implement       Start implementation phase"
    echo "  status          Check current project status"
    echo "  help            Show this help message"
    echo ""
    echo "Workflow:"
    echo "  1. $0 init 'My Project'"
    echo "  2. $0 vision"
    echo "  3. Edit vision.md with goals and requirements"
    echo "  4. $0 research"
    echo "  5. Run research agents"
    echo "  6. $0 plan"
    echo "  7. Generate and review plan"
    echo "  8. $0 implement"
    echo ""
}

# Main command handling
case "${1:-help}" in
    init)
        check_knowledge_vault
        create_vision "${2:-Project}"
        ;;
    vision)
        check_knowledge_vault
        create_vision "${2:-Project}"
        ;;
    research)
        start_research
        ;;
    plan)
        generate_plan
        ;;
    implement)
        start_implementation
        ;;
    status)
        check_status
        ;;
    help)
        show_help
        ;;
    *)
        print_error "Unknown command: $1"
        show_help
        exit 1
        ;;
esac

echo ""
print_status "Workflow: vision → research → plan → implement"
echo "Next: Use 'claude' to run research agents on your vision"