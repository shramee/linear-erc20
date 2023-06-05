use starknet::{StorageAccess, SyscallResult, StorageBaseAddress};

// Token type, no Copy
#[derive(Drop, storage_access::StorageAccess)]
struct Tokens {
    amount: u256, 
}

impl StorageAccessTokens of StorageAccess<Tokens> {
    // StorageAccess read for Tokens
    fn read(address_domain: u32, base: StorageBaseAddress) -> SyscallResult<Tokens> {
        Result::Ok(Tokens { amount: StorageAccess::<u256>::read(address_domain, base)? })
    }

    // StorageAccess write for Tokens
    fn write(address_domain: u32, base: StorageBaseAddress, value: Tokens) -> SyscallResult<()> {
        StorageAccess::<u256>::write(address_domain, base, value.amount)
    }
}
