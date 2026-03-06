# Workflow Completion & Cleanup (scheissehoch8)

Complete workflow: review tasks, update documentation, commit, merge, push, and cleanup.

**Task context:** $ARGUMENTS

---

## Phase 1: Task & Subtask Review

### 1.1 Review Active Work
```bash
# Check current git status
git status

# See recent commits
git log --oneline -10

# Check current branch
git branch --show-current
```

### 1.2 Load Task Context
- Read `.sisyphus/plans/*.md` for active work plan
- Identify completed tasks from plan TODOs
- List remaining/incomplete tasks
- Note any blocked or deferred items

### 1.3 Task Verification Checklist
For each completed task, verify:
- [ ] All TODO items checked off
- [ ] Code changes match task specification
- [ ] Tests added and passing
- [ ] No `todo!()` markers left in modified code
- [ ] No commented-out code
- [ ] No console.log/debug prints in production code

---

## Phase 2: Update Documentation

### 2.1 Update AGENTS.md Files
- Run `/init-deep` if project structure changed
- Or manually update affected AGENTS.md files:
  - Add new modules/functions if significant additions
  - Update conventions if new patterns introduced
  - Document anti-patterns if new gotchas found

### 2.2 Update README Files
For each modified module:
- Check if README.md exists in module directory
- Update usage examples if API changed
- Update feature list if new capabilities added
- Ensure code examples still work

### 2.3 Update Main Documentation
If significant changes:
```bash
# Check for docs/ directory
ls -la docs/

# Update relevant documentation files
```

### 2.4 Generate CHANGELOG Entry
If user-facing changes:
- Create/update `CHANGELOG.md`
- List added features, fixes, breaking changes
- Follow conventional commits format

---

## Phase 3: Code Quality Cleanup

### 3.1 Remove Dead Code
```bash
# Find commented-out code blocks
grep -rn "//.*TODO\|//.*FIXME\|//.*XXX" src/ --include="*.rs"

# Find unused imports (rustc will warn)
cargo check 2>&1 | grep "unused"

# Find unreachable code
cargo clippy --all 2>&1 | grep "unreachable"
```

### 3.2 Code Formatting
```bash
# Format all code
cargo fmt --all

# Check formatting without modifying
cargo fmt --all -- --check
```

### 3.3 Linting & Warnings
```bash
# Run clippy with all lints
cargo clippy --all --all-features -- -D warnings

# Fix auto-fixable lints
cargo clippy --all --all-features --fix
```

### 3.4 Remove Temporary Files
```bash
# Find temporary files
find . -name "*.tmp" -o -name "*.bak" -o -name "*~"

# Find debug/test artifacts
find . -name "*.profdata" -o -name "*.profraw"
```

### 3.5 Update TODO Markers
For each `todo!()` in modified files:
- [ ] Implement or remove
- [ ] If keeping, add comment explaining why
- [ ] Create GitHub issue for tracking
- [ ] Add `// TODO(#issue-number): description` format

---

## Phase 4: Test Verification

### 4.1 Run Full Test Suite
```bash
# Run all tests
cargo test --all

# Run with all features
cargo test --all --all-features

# Calculate test coverage (if tools available)
cargo tarpaulin --out Html --output-dir target/coverage
```

### 4.2 Integration Tests
```bash
# Run integration tests
cargo test --all -- --ignored  # For ignored tests
cargo test --all --all-features

# Check for specific database tests
cargo test --features sqlite
cargo test --features mongodb
```

### 4.3 Test Results Summary
- Total tests run: X
- Passed: Y
- Failed: Z
- Ignored: N
- Coverage: XX%

If any failures:
- List failing tests with file:line
- Show error messages
- HALT - Do not proceed to commit

---

## Phase 5: Git Operations

### 5.1 Pre-Commit Checks
```bash
# Ensure clean state
git status

# Check for large files accidentally staged
git diff --cached --stat | grep -E '\s+[0-9]{6,}\s'

# Verify commit will include expected files
git diff --cached --name-only
```

### 5.2 Stage Changes
```bash
# Stage all changes
git add -A

# Or stage selectively (safer)
git add src/
git add docs/
git add .opencode/commands/
git add AGENTS.md
git add README.md
git add CHANGELOG.md
```

### 5.3 Create Commit
```bash
# Generate commit message from task context
git commit -m "$(cat <<'EOF'
feat(module): brief description

- Completed task/subtask verification
- Updated documentation files
- Cleaned up code quality issues
- All tests passing

Closes #issue-number (if applicable)
EOF
)"
```

**Commit Message Format:**
- Use conventional commits: `feat|fix|docs|refactor|test|chore`
- Include scope/module name
- List key changes in bullet points
- Reference issues/prs

### 5.4 Create Branch (if needed)
If on main/master and this is a feature:
```bash
# Create feature branch
git checkout -b feature/description

# Or if branch already exists
git checkout feature/description
```

---

## Phase 6: Merge & Push

### 6.1 Pre-Merge Checks
```bash
# Fetch latest from remote
git fetch origin

# Check if branch is behind
git log HEAD..origin/main --oneline

# Rebase if behind
git rebase origin/main

# Resolve any conflicts
# Then continue rebase
git rebase --continue
```

### 6.2 Merge Strategy

#### Option A: Direct Push (Small Changes)
```bash
# Push to remote
git push origin HEAD
```

#### Option B: Pull Request (Large Changes)
```bash
# Push branch
git push -u origin feature/description

# Create PR description
gh pr create --title "feat(description): brief" --body "$(cat <<'EOF'
## Changes
- Change 1
- Change 2

## Testing
- All tests passing
- Coverage: XX%

## Checklist
- [ ] Documentation updated
- [ ] Tests added/updated
- [ ] Code cleanup done
EOF
)"
```

#### Option C: Merge to Main (After PR)
```bash
# Switch to main
git checkout main

# Pull latest
git pull origin main

# Merge feature branch
git merge --no-ff feature/description

# Push to main
git push origin main
```

### 6.3 Push Verification
```bash
# Verify push succeeded
git log origin/main --oneline -5

# Check remote status
git remote -v
```

---

## Phase 7: Post-Merge Cleanup

### 7.1 Delete Feature Branch (After Merge)
```bash
# Delete local branch
git branch -d feature/description

# Delete remote branch
git push origin --delete feature/description
```

### 7.2 Update Local Branches
```bash
# Fetch all remotes
git fetch --all --prune

# Update tracking branches
git branch -a
```

### 7.3 Clean Git History
```bash
# Optional: Squash commits if too many
git rebase -i HEAD~N  # Where N = number of commits

# Optional: Clean up merged branches
git branch --merged | grep -v "\*" | xargs -n 1 git branch -d
```

### 7.4 Final Status Check
```bash
# Verify clean working directory
git status

# Show final state
git log --oneline --graph --all -10

# Check for untracked files
git clean -n -d  # Dry run
```

---

## Phase 8: Task Management Cleanup

### 8.1 Archive Completed Tasks
- Move completed tasks from `.sisyphus/plans/*.md` to `.sisyphus/completed/`
- Or mark as completed in plan file
- Update task tracking system

### 8.2 Update Project Management
If using external tracking:
- Mark GitHub issues as closed
- Update project board
- Add completion notes

### 8.3 Generate Summary Report
Create `.sisyphus/logs/YYYY-MM-DD-completion.md`:
```markdown
# Task Completion Report - {DATE}

## Summary
- Tasks completed: X
- Files modified: Y
- Tests passing: Z
- Coverage: XX%

## Changes Made
- [Change 1]
- [Change 2]

## Documentation Updated
- AGENTS.md
- README.md
- CHANGELOG.md

## Git Operations
- Commit: {SHA}
- Merged to: main
- Pushed to: origin

## Issues Closed
- #123
- #456
```

---

## Success Criteria

Final checklist before marking complete:
- [ ] All tasks reviewed and verified
- [ ] Documentation updated (AGENTS.md, README, CHANGELOG)
- [ ] Code cleanup complete (no dead code, formatted, linted)
- [ ] All tests passing (unit + integration)
- [ ] Changes committed with proper message
- [ ] Changes merged to main/feature branch
- [ ] Changes pushed to remote
- [ ] Feature branches cleaned up
- [ ] Task tracking updated

---

## Error Handling

### If Tests Fail
1. HALT immediately
2. Show failing tests with output
3. Suggest fixes
4. Do NOT commit or push

### If Merge Conflicts
1. HALT before merge
2. Show conflicting files
3. Guide conflict resolution
4. Re-run tests after resolution

### If Push Fails
1. Show error message
2. Check remote permissions
3. Resolve authentication issues
4. Retry push

---

## Rollback Procedures

### Undo Commit (Not Pushed)
```bash
git reset --soft HEAD~1
```

### Undo Push (Already Pushed - DANGEROUS)
```bash
# Only if no one else has pulled
git reset --hard HEAD~1
git push --force origin HEAD
```

### Revert Merge
```bash
git revert -m 1 <merge-commit-sha>
git push origin HEAD
```

---

**Usage Examples:**
```
/scheissehoch8                                          # Full workflow
/scheissehoch8 focusing on auth module changes          # With context
/scheissehoch8 after completing issue #123             # With issue ref
```

$ARGUMENTS