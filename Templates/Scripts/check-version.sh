#!/bin/bash
# Quick ContextKit version checker
# Usage: ./check-version.sh

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🧠 ContextKit Version Check"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Get global version
if [ -f ~/.ContextKit/VERSION ]; then
    GLOBAL_VERSION=$(cat ~/.ContextKit/VERSION)
    echo -e "${BLUE}Global Installation:${NC} v$GLOBAL_VERSION"
else
    GLOBAL_VERSION="not-installed"
    echo -e "${RED}Global Installation:${NC} Not installed"
    echo -e "${YELLOW}💡 Install:${NC} curl -fsSL https://raw.githubusercontent.com/mehrdad-tat/ContextKit/main/install.sh | sh"
fi

# Get project version
if [ -f .claude/commands/ctxk/VERSION ]; then
    PROJECT_VERSION=$(cat .claude/commands/ctxk/VERSION)
    echo -e "${BLUE}Project Commands:${NC}    v$PROJECT_VERSION"
else
    PROJECT_VERSION="not-initialized"
    echo -e "${YELLOW}Project Commands:${NC}    Not initialized"
    echo -e "${YELLOW}💡 Initialize:${NC} /ctxk:proj:init"
fi

echo ""

# Compare and suggest action
if [ "$GLOBAL_VERSION" = "not-installed" ]; then
    echo -e "${RED}❌ ContextKit not installed globally${NC}"
    echo ""
    exit 1
elif [ "$PROJECT_VERSION" = "not-initialized" ]; then
    echo -e "${YELLOW}⚠️  Project not initialized with ContextKit${NC}"
    echo -e "${YELLOW}💡 Run:${NC} /ctxk:proj:init"
    echo ""
    exit 0
elif [ "$GLOBAL_VERSION" = "$PROJECT_VERSION" ]; then
    echo -e "${GREEN}✅ Everything is up to date!${NC}"
    echo ""
    exit 0
else
    # Version mismatch - need update
    echo -e "${YELLOW}⚠️  Update available${NC}"
    echo ""
    echo -e "   Current:  ${RED}v$PROJECT_VERSION${NC}"
    echo -e "   Latest:   ${GREEN}v$GLOBAL_VERSION${NC}"
    echo ""
    echo -e "${YELLOW}💡 Run:${NC} /ctxk:proj:migrate"
    echo ""
    exit 0
fi
