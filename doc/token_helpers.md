### Function `balance`

Gets u256 balance of an account

#### Parameters:
TokenIdentifieraccount TokenColon: TokenIdentifierContractAddress TokenRParen

#### Returns:
u256 

#### Source code
```rust
    // Gets u256 balance of an account
    fn balance(account: ContractAddress) -> u256 {
        tokens_store::read(account).amount
    }
```

&nbsp;

### Function `withdraw`

Withraw Tokens from an account
Only if account is the caller

#### Parameters:
TokenIdentifieraccount TokenColon: TokenIdentifierContractAddress TokenComma
TokenIdentifieramount TokenColon: TokenIdentifieru256 TokenRParen

#### Returns:
Tokens 

#### Source code
```rust
    // Withraw Tokens from an account
    // Only if account is the caller
    fn withdraw(account: ContractAddress, amount: u256) -> Tokens {
        assert(account == get_caller_address(), 'Only owner can withdraw');
        withdraw_unsafe(account, amount)
    }
```

&nbsp;

### Function `withdraw_unsafe`

Withraw Tokens from an account
Unsafe, verify if the caller can withdraw from account

#### Parameters:
TokenIdentifieraccount TokenColon: TokenIdentifierContractAddress TokenComma
TokenIdentifierwithdraw_amount TokenColon: TokenIdentifieru256 TokenRParen

#### Returns:
Tokens 

#### Source code
```rust
    // Withraw Tokens from an account
    // Unsafe, verify if the caller can withdraw from account
    fn withdraw_unsafe(account: ContractAddress, withdraw_amount: u256) -> Tokens {
        let Token{amount } = tokens_store::read(account);
        tokens_store::write(account, Tokens { amount: amount - withdraw_amount });
        return Tokens { amount: withdraw_amount };
    }
```

&nbsp;

### Function `deposit`

Takes tokens and deposit into an account (consumes)

#### Parameters:
TokenIdentifieraccount TokenColon: TokenIdentifierContractAddress TokenComma
TokenIdentifiertokens TokenColon: TokenIdentifierTokens TokenRParen

#### Source code
```rust
    // Takes tokens and deposit into an account (consumes)
    fn deposit(account: ContractAddress, tokens: Tokens) {
        let Token{amount } = tokens_store::read(account);
        tokens_store::write(account, Tokens { amount: amount - tokens.amount });
    }
```

&nbsp;

### Function `mint`

Mints Tokens to an account

#### Parameters:
TokenIdentifieraccount TokenColon: TokenIdentifierContractAddress TokenComma
TokenIdentifiermint_amount TokenColon: TokenIdentifieru256 TokenRParen

#### Source code
```rust
    // Mints Tokens to an account
    fn mint(account: ContractAddress, mint_amount: u256) {
        let Token{amount } = tokens_store::read(account);
        tokens_store::write(account, Tokens { amount: amount + mint_amount });
        total_token_supply::write(total_token_supply::read() + mint_amount);
    }
```

&nbsp;

### Function `total_supply`

Returns total supply amount of tokens

#### Parameters:
TokenRParen

#### Returns:
u256 

#### Source code
```rust
    // Returns total supply amount of tokens
    fn total_supply() -> u256 {
        total_token_supply::read()
    }
```

&nbsp;

