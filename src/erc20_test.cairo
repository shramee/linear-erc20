use starknet::contract_address_const;
use starknet::ContractAddress;
use starknet::testing::set_caller_address;
use integer::u256;
use integer::u256_from_felt252;
use integer::BoundedInt;
use traits::Into;
use super::erc20::ERC20Contract;

// Constants

const NAME: felt252 = 111;
const SYMBOL: felt252 = 222;
const DECIMALS: u8 = 2;

// Helpers

fn setup(supply: felt252) -> ContractAddress {
    let initial_supply: u256 = u256_from_felt252(supply);
    let owner: ContractAddress = contract_address_const::<'owner'>();
    // Set owner as default caller
    set_caller_address(owner);

    ERC20Contract::constructor(NAME, SYMBOL, DECIMALS, initial_supply, owner);
    owner
}

//
// Tests
//

#[test]
#[available_gas(2000000)]
fn test_initializer() {
    let owner = setup(20000);
    assert(ERC20Contract::get_total_supply() == u256_from_felt252(20000), 'Supply should 20000');
    assert(ERC20Contract::balance_of(owner) == u256_from_felt252(20000), 'Owner bal not 9000');
}

#[test]
#[available_gas(2000000)]
fn test_transfer() {
    let owner = setup(10000);
    let bob: ContractAddress = contract_address_const::<'bob'>();
    ERC20Contract::transfer(bob, u256_from_felt252(1000));
    assert(ERC20Contract::balance_of(bob) == u256_from_felt252(1000), 'Bob\'s bal not 1000');
    assert(ERC20Contract::balance_of(owner) == u256_from_felt252(9000), 'Owner bal not 9000');
}
