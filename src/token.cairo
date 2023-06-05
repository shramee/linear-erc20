use starknet::{StorageAccess, SyscallResult, StorageBaseAddress};

#[derive(Drop, storage_access::StorageAccess)]
struct Tokens {
    amount: u256, 
}

impl StorageAccessTokens of StorageAccess<Tokens> {
    fn read(address_domain: u32, base: StorageBaseAddress) -> SyscallResult<Tokens> {
        Result::Ok(Tokens { amount: StorageAccess::<u256>::read(address_domain, base)? })
    }
    fn write(address_domain: u32, base: StorageBaseAddress, value: Tokens) -> SyscallResult<()> {
        StorageAccess::<u256>::write(address_domain, base, value.amount)
    }
}

#[contract]
mod TokenUtils {
    use zeroable::Zeroable;
    use starknet::get_caller_address;
    use starknet::ContractAddress;
    use starknet::contract_address_const;
    use starknet::contract_address_try_from_felt252;
    use traits::Into;
    use traits::TryInto;
    use option::OptionTrait;

    struct Storage {
        balances: LegacyMap::<ContractAddress, u256>, 
    }
    fn read() {// balances::read()
    }

    fn withdraw() {// balances::read()
    }

    fn mint() {}
}
