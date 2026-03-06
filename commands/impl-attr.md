# Attribute Type Implementation

Implement a new attribute type following project patterns.

**Attribute to implement:** $ARGUMENTS

---

## Implementation Steps

### 1. Study Existing Patterns

Read these reference files:
- `src/data_objects/attributes/ty/single.rs` - Existing attribute types
- `src/data_objects/attributes/value/single/` - Value implementations
- `src/data_objects/attributes/ty/attr_ty.rs` - Type registry
- `src/data_objects/README.md` - Attribute system overview

### 2. Create Type Definition

In `src/data_objects/attributes/ty/single.rs`:
- Add new type enum variant
- Follow existing naming conventions (use `str32` for names)
- Add appropriate derives (Clone, Debug, PartialEq, etc.)

### 3. Create Value Implementation

Create file: `src/data_objects/attributes/value/single/{attribute_name}.rs`

Must implement:
- `AttributeValue` trait
- Validation logic (if applicable)
- Error handling with `thiserror`
- Thread-safe design (DashMap-compatible if shared)

### 4. Update Type Registry

In `attr_ty.rs`:
- Register the new type
- Add type resolution logic
- Update match statements

### 5. Add Embedded Tests

In same file, add:
```rust
#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_{attribute}_creation() {
        // Test basic creation
    }
    
    #[test]
    fn test_{attribute}_validation() {
        // Test validation rules
    }
    
    #[test]
    fn test_{attribute}_error_cases() {
        // Test error handling
    }
}
```

### 6. Run Tests

```bash
cargo test --all
cargo clippy --all
```

## Code Style Requirements

- Edition 2024 syntax
- Use nightly features: `#![feature(never_type, trim_prefix_suffix, str_as_str)]`
- Thread-safe: Use `DashMap`/`DashSet` for shared state
- Error types: Use `thiserror` for custom errors
- No `clone()` on `Price` values (deliberate design)
- Handle arithmetic overflow in Price operations

## Verification Checklist

- [ ] Type defined with correct derives
- [ ] Value object implements `AttributeValue` trait
- [ ] Type registered in `attr_ty.rs`
- [ ] Embedded tests added (not separate test files)
- [ ] All tests pass: `cargo test --all`
- [ ] No clippy warnings: `cargo clippy --all`
- [ ] Thread-safe if used in shared context
- [ ] Documentation comments on public items

## Common Pitfalls

1. **Do NOT use `String` for attribute names** - Use `str32` (fixed 32-byte string)
2. **Do NOT use `std::collections::HashMap` in shared context** - Use `DashMap`
3. **DO handle Price overflow explicitly** - May panic on overflow
4. **DO check for nightly feature requirements** - Edition 2024 is nightly-only

$ARGUMENTS