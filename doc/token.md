### Function `read`

StorageAccess read for Tokens

#### Parameters:
TokenIdentifieraddress_domain TokenColon: TokenIdentifieru32 TokenComma
TokenIdentifierbase TokenColon: TokenIdentifierStorageBaseAddress TokenRParen

#### Returns:
SyscallResult < Tokens > 

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

#### Parameters:
TokenIdentifieraddress_domain TokenColon: TokenIdentifieru32 TokenComma
TokenIdentifierbase TokenColon: TokenIdentifierStorageBaseAddress TokenComma
TokenIdentifiervalue TokenColon: TokenIdentifierTokens TokenRParen

#### Returns:
SyscallResult < ( ) > 

#### Source code
```rust
    // StorageAccess write for Tokens
    fn write(address_domain: u32, base: StorageBaseAddress, value: Tokens) -> SyscallResult<()> {
        StorageAccess::<u256>::write(address_domain, base, value.amount)
    }
```

&nbsp;

