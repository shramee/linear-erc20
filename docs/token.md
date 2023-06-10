### Function `read`

StorageAccess read for Tokens

| Name | Type |
|---|---|
| Param `address_domain` | `u32` |
| Param `base` | `StorageBaseAddress` |
| **Returns** | `SyscallResult < Tokens > ` |

#### Source code 
```rust
    // StorageAccess read for Tokens
    fn read(address_domain: u32, base: StorageBaseAddress) -> SyscallResult<Tokens> {
        Result::Ok(Tokens { amount: StorageAccess::<u256>::read(address_domain, base)? })
    }
```

&nbsp;

### Function `write`

StorageAccess write for Tokens

| Name | Type |
|---|---|
| Param `address_domain` | `u32` |
| Param `base` | `StorageBaseAddress` |
| Param `value` | `Tokens` |
| **Returns** | `SyscallResult < ( ) > ` |

#### Source code 
```rust
    // StorageAccess write for Tokens
    fn write(address_domain: u32, base: StorageBaseAddress, value: Tokens) -> SyscallResult<()> {
        StorageAccess::<u256>::write(address_domain, base, value.amount)
    }
```

&nbsp;

