# OpenCode Custom Commands

A collection of custom slash commands for OpenCode AI coding assistant.

## 🚀 Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/GrxE/opencode-commands/main/install.sh | bash
```

## 📦 Available Commands

### `/quality` - Code Quality Audit
Scans codebase for quality issues:
- `todo!()` markers and incomplete work
- Dangerous `unwrap()` calls
- Thread safety issues (HashMap vs DashMap)
- Edition 2024/nightly feature usage
- Groups findings by priority (HIGH/MEDIUM/LOW)

**Usage:** `/quality`

---

### `/checkup` - Custom Verification Checklist
Run your own step-by-step verification with PASS/FAIL reporting.

**Usage:**
```
/checkup
Check that:
1. All tests pass with `cargo test --all`
2. No clippy warnings
3. All public functions have doc comments
4. No `unwrap()` in production code
```

**Features:**
- Executes each verification step
- Captures actual output
- Reports PASS/FAIL with evidence
- Shows diffs before auto-fixes

---

### `/impl-attr` - Attribute Type Implementation
Guides complete attribute type creation for enx_base/DOM projects.

**Usage:** `/impl-attr Price`

**Workflow:**
1. Shows existing attribute patterns
2. Creates type definition with proper derives
3. Implements `AttributeValue` trait
4. Registers in type registry
5. Adds embedded tests
6. Verifies with `cargo test --all`

**Includes:**
- Project-specific patterns (`str32`, DashMap, edition 2024)
- Common pitfalls to avoid
- Thread-safe design patterns

---

### `/impl-valueobject` - Value Object Implementation
Guides value object creation with derive macros.

**Usage:** `/impl-valueobject CustomerId`

**Workflow:**
1. Shows existing value object patterns
2. Applies derive macros from proc-macros
3. Implements required traits (`TryFrom`, `Display`)
4. Adds validation logic with `thiserror`
5. Creates embedded tests
6. Verifies implementation

---

### `/scheissehoch8` - Complete Workflow Finalization
**The ultimate workflow completion command.**

**Usage:**
```
/scheissehoch8                              # Full workflow
/scheissehoch8 auth module changes         # With context
/scheissehoch8 after completing issue #123
```

**8 Comprehensive Phases:**
1. **Task Review** - Verify TODOs, check task completion
2. **Documentation** - Update AGENTS.md, README, CHANGELOG
3. **Code Cleanup** - Format, lint, remove dead code
4. **Test Verification** - Run full test suite
5. **Git Operations** - Stage, commit, proper message
6. **Merge & Push** - Rebase, merge, or PR workflow
7. **Post-Merge Cleanup** - Delete branches, clean history
8. **Task Management** - Archive tasks, generate report

**Error Handling:**
- Halts on test failures
- Guides conflict resolution
- Provides rollback procedures

---

## 📋 Manual Installation

If you prefer manual installation:

```bash
# Create commands directory
mkdir -p ~/.opencode/commands

# Download individual commands
curl -fsSL https://raw.githubusercontent.com/GrxE/opencode-commands/main/commands/quality.md -o ~/.opencode/commands/quality.md
curl -fsSL https://raw.githubusercontent.com/GrxE/opencode-commands/main/commands/checkup.md -o ~/.opencode/commands/checkup.md
curl -fsSL https://raw.githubusercontent.com/GrxE/opencode-commands/main/commands/impl-attr.md -o ~/.opencode/commands/impl-attr.md
curl -fsSL https://raw.githubusercontent.com/GrxE/opencode-commands/main/commands/impl-valueobject.md -o ~/.opencode/commands/impl-valueobject.md
curl -fsSL https://raw.githubusercontent.com/GrxE/opencode-commands/main/commands/scheissehoch8.md -o ~/.opencode/commands/scheissehoch8.md
```

## 🔄 Updating

To update to the latest version:

```bash
curl -fsSL https://raw.githubusercontent.com/GrxE/opencode-commands/main/install.sh | bash
```

## 🎨 Customization

Edit `~/.opencode/commands/*.md` files to customize for your project:
- Add project-specific commands
- Modify verification steps
- Adjust code quality rules
- Add custom git workflows

## 📁 Project-Level vs User-Level

**User-level** (`~/.opencode/commands/`):
- Available across all your projects
- Personal workflows
- User-specific preferences

**Project-level** (`.opencode/commands/`):
- Shared with team via git
- Project-specific workflows
- Team conventions

---

**Made with ❤️ for OpenCode users**