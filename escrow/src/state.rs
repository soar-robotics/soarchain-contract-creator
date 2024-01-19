use cosmwasm_std::{ Order, StdResult, Storage};
use cw_storage_plus::Map;
use cosmwasm_std::{Addr, Uint128};

use crate::escrow::Escrow;

pub const ESCROWS: Map<&str, Escrow> = Map::new("escrow");
pub const BALANCES: Map<&Addr, Uint128> = Map::new("balance");

/// This returns the list of ids for all registered escrows
pub fn all_escrow_ids(storage: &dyn Storage) -> StdResult<Vec<String>> {
    ESCROWS
        .keys(storage, None, None, Order::Ascending)
        .collect()
}