### Function `setup_mint`

Sets up with mint_amount minted to account 'bob'

| Name | Type |
|---|---|
| Param `mint_amount` | `felt252` |
| **Returns** | `ContractAddress ` |

#### Source code 
```rust
// Sets up with mint_amount minted to account 'bob'
fn setup_mint(mint_amount: felt252) -> ContractAddress {
    let ac = contract_address_const::<'bob'>();
    TokenHelpers::mint(ac, u256_from_felt252(mint_amount));
    ac
}
```

&nbsp;

### Function `test_mint_and_supply`

Test tokens are minted and supply is updated

#### Source code 
```rust
// Test tokens are minted and supply is updated
#[test]
#[available_gas(20000000)]
fn test_mint_and_supply() {
    let ac = setup_mint(250);
    assert(TokenHelpers::total_supply() == u256_from_felt252(250), 'Supply should 250');
    assert(TokenHelpers::balance(ac) == u256_from_felt252(250), 'Owner bal not 9000');
}
```

&nbsp;

### Function `test_withdraw_unsafe`

Tests that withdraw unsafe returns Tokens struct and removes Tokens from account

#### Source code 
```rust
// Tests that withdraw unsafe returns Tokens struct and removes Tokens from account
#[test]
#[available_gas(20000000)]
fn test_withdraw_unsafe() {
    let ac = setup_mint(250);
    let tokens: Tokens = TokenHelpers::withdraw_unsafe(ac, u256_from_felt252(50));
    assert(tokens.amount == u256_from_felt252(50), 'Should have withdrawn 50 Tokens');
    assert(TokenHelpers::balance(ac) == u256_from_felt252(200), 'Owner bal not 250 - 50');
}
```

&nbsp;

### Function `test_withdraw_wrong_caller`

Tests that safe withdraw panics for caller different from account

#### Source code 
```rust
// Tests that safe withdraw panics for caller different from account
#[test]
#[should_panic]
#[available_gas(20000000)]
fn test_withdraw_wrong_caller() {
    let ac = setup_mint(250);
    TokenHelpers::withdraw(ac, u256_from_felt252(250));
}
```

&nbsp;

### Function `test_withdraw_safe`

Tests that safe withdraw works with correct account caller
And returns Tokens struct and removes Tokens from account

#### Source code 
```rust
// Tests that safe withdraw works with correct account caller
// And returns Tokens struct and removes Tokens from account
#[test]
#[available_gas(20000000)]
fn test_withdraw_safe() {
    let ac = setup_mint(250);
    set_caller_address(ac);
    let tokens: Tokens = TokenHelpers::withdraw(ac, u256_from_felt252(50));
    assert(tokens.amount == u256_from_felt252(50), 'Should have withdrawn 50 Tokens');
    assert(TokenHelpers::balance(ac) == u256_from_felt252(200), 'Owner bal not 250 - 50');
}
```

&nbsp;

