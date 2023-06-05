use super::token::{Tokens, TokenHelpers};
use starknet::contract_address_const;
use starknet::ContractAddress;
use starknet::testing::set_caller_address;
use integer::u256_from_felt252;

// Sets up with mint_amount minted to account 'bob'
fn setup_mint(mint_amount: felt252) -> ContractAddress {
    let ac = contract_address_const::<'bob'>();
    TokenHelpers::mint(ac, u256_from_felt252(mint_amount));
    ac
}

// Test tokens are minted and supply is updated
#[test]
#[available_gas(20000000)]
fn test_mint_and_supply() {
    let ac = setup_mint(250);
    assert(TokenHelpers::total_supply() == u256_from_felt252(250), 'Supply should 250');
    assert(TokenHelpers::balance(ac) == u256_from_felt252(250), 'Owner bal not 9000');
}

// Tests that withdraw unsafe returns Tokens struct and removes Tokens from account
#[test]
#[available_gas(20000000)]
fn test_withdraw_unsafe() {
    let ac = setup_mint(250);
    let tokens: Tokens = TokenHelpers::withdraw_unsafe(ac, u256_from_felt252(50));
    assert(tokens.amount == u256_from_felt252(50), 'Should have withdrawn 50 Tokens');
    assert(TokenHelpers::balance(ac) == u256_from_felt252(200), 'Owner bal not 250 - 50');
}

// Tests that safe withdraw panics for caller different from account
#[test]
#[should_panic]
#[available_gas(20000000)]
fn test_withdraw_wrong_caller() {
    let ac = setup_mint(250);
    TokenHelpers::withdraw(ac, u256_from_felt252(250));
}

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
