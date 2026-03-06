# Custom Code Verification

Run a step-by-step verification checklist on your code, based on your custom prompt.

$ARGUMENTS

---

Execute the verification steps provided in the arguments above. For each step:

1. **Run the check**: Execute the specified command, grep, or inspection
2. **Capture results**: Record actual output, file contents, or findings
3. **Evaluate**: Determine if the result matches expectations
4. **Report**: Provide PASS/FAIL status with evidence

## Output Format

For each verification step:

### Step N: [Name]
- **Command**: `[the command to run]`
- **Result**: `[actual output or findings]`
- **Expected**: `[what was expected]`
- **Status**: ✅ PASS / ❌ FAIL
- **Notes**: `[any observations or recommendations]`

## Evidence Requirements

- Extract actual file contents for verification
- Show grep output with line numbers
- Include test output (pass/fail counts)
- Quote specific code snippets

## Final Summary

After all steps:
- **Total Steps**: X
- **Passed**: Y
- **Failed**: Z
- **Overall**: ✅ ALL CHECKS PASS / ⚠️ NEEDS ATTENTION

## Auto-Fixes

If any checks fail and can be auto-fixed:
1. Show the diff
2. Ask for confirmation
3. Apply if approved

---

**Example usage:**
```
/checkup
Check that:
1. All tests pass with `cargo test --all`
2. No clippy warnings with `cargo clippy --all`
3. All public functions have doc comments
4. No `unwrap()` in production code (excluding tests)
5. All `todo!()` markers are documented in a TODOs.md file
```