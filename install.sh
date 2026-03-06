#!/bin/bash
set -e

COMMANDS_DIR="$HOME/.opencode/commands"
REPO_USER="GrxE"
REPO_NAME="opencode-commands"
BRANCH="main"

BASE_URL="https://raw.githubusercontent.com/$REPO_USER/$REPO_NAME/$BRANCH/commands"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}╔═══════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  OpenCode Custom Commands Installer   ║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════╝${NC}"
echo ""

# Check for existing commands
if [ -d "$COMMANDS_DIR" ] && [ "$(ls -A $COMMANDS_DIR 2>/dev/null)" ]; then
  echo -e "${YELLOW}⚠ Commands already installed in $COMMANDS_DIR${NC}"
  read -p "Reinstall/Update? (y/n) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Installation cancelled."
    exit 1
  fi
fi

# Create directory
mkdir -p "$COMMANDS_DIR"

# Commands to install
COMMANDS=(
  "quality"
  "checkup"
  "impl-attr"
  "impl-valueobject"
  "scheissehoch8"
)

FAILED=false

for cmd in "${COMMANDS[@]}"; do
  echo -ne "Installing /$cmd... "
  if curl -fsSL "$BASE_URL/$cmd.md" -o "$COMMANDS_DIR/$cmd.md" 2>/dev/null; then
    echo -e "${GREEN}✓${NC}"
  else
    echo "✗ (failed)"
    FAILED=true
  fi
done

echo ""

if [ "$FAILED" = true ]; then
  echo -e "${YELLOW}Some commands failed to install. Check your internet connection.${NC}"
  exit 1
fi

echo -e "${GREEN}✅ Installation successful!${NC}"
echo ""
echo "Commands installed to: $COMMANDS_DIR"
echo ""
echo "Available commands:"
for cmd in "${COMMANDS[@]}"; do
  echo -e "  ${BLUE}/$cmd${NC}"
done
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Restart OpenCode or your terminal"
echo "2. Use commands like: ${BLUE}/quality${NC}, ${BLUE}/checkup${NC}, ${BLUE}/scheissehoch8${NC}"
echo ""
echo "Command descriptions:"
echo "  /quality           - Code quality audit (todos, unwraps, thread safety)"
echo "  /checkup           - Custom verification checklist (PASS/FAIL reporting)"
echo "  /impl-attr        - Attribute type implementation workflow"
echo "  /impl-valueobject - Value object implementation workflow"
echo "  /scheissehoch8   - Complete workflow finalization (8 phases)"
echo ""
