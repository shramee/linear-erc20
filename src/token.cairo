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
mod TokenHelpers {
    use super::Tokens;
    use zeroable::Zeroable;
    use starknet::get_caller_address;
    use starknet::ContractAddress;
    use starknet::contract_address_const;
    use starknet::contract_address_try_from_felt252;
    use traits::Into;
    use traits::TryInto;
    use option::OptionTrait;

    struct Storage {
        total_token_supply: u256,
        tokens_store: LegacyMap::<ContractAddress, Tokens>,
    }

    // Gets u256 balance of an account
    fn balance(account: ContractAddress) -> u256 {
        tokens_store::read(account).amount
    }

    // Withraw Tokens from an account
    // Only if account is the caller
    fn withdraw(account: ContractAddress, amount: u256) -> Tokens {
        assert(account == get_caller_address(), 'Only owner can withdraw');
        withdraw_unsafe(account, amount)
    }

    // Withraw Tokens from an account
    // Unsafe, verify if the caller can withdraw from account
    fn withdraw_unsafe(account: ContractAddress, withdraw_amount: u256) -> Tokens {
        let Token{amount } = tokens_store::read(account);
        tokens_store::write(account, Tokens { amount: amount - withdraw_amount });
        return Tokens { amount: withdraw_amount };
    }

    // Takes tokens and deposit into an account (consumes)
    fn deposit(account: ContractAddress, tokens: Tokens) {
        let Token{amount } = tokens_store::read(account);
        tokens_store::write(account, Tokens { amount: amount - tokens.amount });
    }

    // Mints Tokens to an account
    fn mint(account: ContractAddress, mint_amount: u256) {
        let Token{amount } = tokens_store::read(account);
        tokens_store::write(account, Tokens { amount: amount + mint_amount });
        total_token_supply::write(total_token_supply::read() + mint_amount);
    }

    // Returns total supply amount of tokens
    fn total_supply() -> u256 {
        total_token_supply::read()
    }
}
