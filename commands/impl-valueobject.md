# Value Object Implementation

Implement a new value object with proper structure and derive macros.

**Value object to implement:** $ARGUMENTS

---

## Implementation Steps

### 1. Study Existing Patterns

Read these reference files:
- `src/data_objects/objects/` - Existing value objects
- `enx-base-proc-macros/src/derive_value_object.rs` - Derive macro implementation
- `src/data_objects/README.md` - Value object system overview

### 2. Define Value Object

Choose location based on domain:
- `src/data_objects/objects/entity.rs` - Entity-related
- `src/data_objects/objects/value_obj.rs` - Generic value objects
- Create new module if separate domain

### 3. Apply Derive Macros

Use proc macros from `enx-base-proc-macros`:
```rust
use enx_base_proc_macros::ValueObject;

#[derive(Debug, Clone, PartialEq, ValueObject)]
pub struct MyValueObject {
    // fields
}
```

Available derives:
- `ValueObject` - Base value object functionality
- Check `enx-base-proc-macros/src/derive_value_object.rs` for full capabilities

### 4. Implement Traits

Required trait implementations:
- `TryFrom` for parsing/validation
- `Display` for string representation
- `Serialize/Deserialize` for persistence (if needed)

### 5. Add Validation

Implement validation logic:
```rust
impl MyValueObject {
    pub fn validate(&self) -> Result<(), ObjectError> {
        // Validation rules
        Ok(())
    }
}
```

Use `thiserror` for error types:
```rust
#[derive(Debug, thiserror::Error)]
pub enum MyValueObjectError {
    #[error("Invalid value: {0}")]
    InvalidValue(String),
}
```

### 6. Add Embedded Tests

```rust
#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_value_object_creation() {
        // Test valid creation
    }
    
    #[test]
    fn test_value_object_validation() {
        // Test validation rules
    }
    
    #[test]
    fn test_value_object_error_cases() {
        // Test invalid inputs
    }
}
```

### 7. Run Tests

```bash
cargo test --all
cargo clippy --all
```

## Code Style Requirements

- Use `str32` for short identifiers/names
- Thread-safe design (consider `Arc` + `DashMap` for shared access)
- Use `rust_decimal` for precise numeric values
- Proper error handling with `thiserror`
- No `clone()` on financial values (Price type)

## Verification Checklist

- [ ] Value object defined with proper derives
- [ ] `TryFrom` implemented for parsing
- [ ] Validation logic implemented
- [ ] Error types defined with `thiserror`
- [ ] Embedded tests added
- [ ] All tests pass
- [ ] No clippy warnings
- [ ] Thread-safe if shared across modules

## Value Object Characteristics

Value objects should be:
1. **Immutable** - No interior mutability
2. **Equality by value** - Two instances with same data are equal
3. **Self-validating** - Constructor enforces invariants
4. **Serializable** - For persistence/transmission
5. **Domain-specific** - Represent business concepts

## Common Pitfalls

1. **Mutable state in value objects** - Value objects should be immutable
2. **Missing validation** - All invariants should be enforced at construction
3. **Using `String` for identifiers** - Use `str32` for performance
4. **Clone on Price** - Financial values should not be cloned casually

$ARGUMENTS