# Linear ERC20

A linear type system implementation of ERC20

## Functions

### `TokenHelpers`

-   [`fn balance`](doc/token_helpers.md#function-balance) Gets u256 balance of an account
-   [`fn withdraw`](doc/token_helpers.md#function-withdraw) Withdraw Tokens from an account. Only if account is the caller
-   [`fn withdraw_unsafe`](doc/token_helpers.md#function-withdraw_unsafe) Withdraw Tokens from an account. Unsafe, verify if the caller can withdraw from account
-   [`fn deposit`](doc/token_helpers.md#function-deposit) Takes tokens and deposit into an account (consumes)
-   [`fn mint`](doc/token_helpers.md#function-mint) Mints Tokens to an account
-   [`fn total_supply`](doc/token_helpers.md#function-total_supply) Returns total supply amount of tokens

### Tests

-   [`fn setup_mint`](doc/token_tests.md#function-setup_mint) Sets up with mint_amount minted to account 'bob'
-   [`fn test_mint_and_supply`](doc/token_tests.md#function-test_mint_and_supply) Test tokens are minted and supply is updated
-   [`fn test_withdraw_unsafe`](doc/token_tests.md#function-test_withdraw_unsafe) Tests that withdraw unsafe returns Tokens struct and removes Tokens from account
-   [`fn test_withdraw_wrong_caller`](doc/token_tests.md#function-test_withdraw_wrong_caller) Tests that safe withdraw panics for caller different from account
-   [`fn test_withdraw_safe`](doc/token_tests.md#function-test_withdraw_safe) Tests that safe withdraw works with correct account caller. And returns Tokens struct and removes Tokens from account
