use cosmwasm_std::{ Order, StdResult, Storage};
use cw_storage_plus::{Map, Item};
use cosmwasm_std::{Addr, Uint128};
use serde::{Serialize, Deserialize};

use crate::escrow::Escrow;

pub const ESCROWS: Map<&str, Escrow> = Map::new("escrow");
pub const BALANCES: Map<&Addr, Uint128> = Map::new("balance");
pub const STATE: Item<State> = Item::new("state");

#[derive(Serialize, Deserialize)]
pub struct State {
    pub owner: String,
}

/// This returns the list of ids for all registered escrows
pub fn all_escrow_ids(storage: &dyn Storage) -> StdResult<Vec<String>> {
    ESCROWS
        .keys(storage, None, None, Order::Ascending)
        .collect()
}