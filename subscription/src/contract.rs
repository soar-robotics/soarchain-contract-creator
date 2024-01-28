#[cfg(not(feature = "library"))]
use cosmwasm_std::entry_point;
use cosmwasm_std::{Deps, DepsMut, Env, MessageInfo, Addr};
use cosmwasm_std::{Response, StdResult };
use cosmwasm_std::{Binary, to_json_binary};
use cosmwasm_std::Order;
use cw2::{set_contract_version, get_contract_version};
use semver::Version;

use crate::error::ContractError;
use crate::msg::{ InstantiateMsg, MigrateMsg, ExecuteMsg, SubscribeMsg, QueryMsg };
use crate::state::{Record, records};

// version info for migration info
const CONTRACT_NAME: &str = "crates.io:subscribe";
const CONTRACT_VERSION: &str = env!("CARGO_PKG_VERSION");

#[cfg_attr(not(feature = "library"), entry_point)]
pub fn instantiate(
    _deps: DepsMut,
    _env: Env,
    _info: MessageInfo,
    _msg: InstantiateMsg,
) -> Result<Response, ContractError> {
    set_contract_version(_deps.storage, CONTRACT_NAME, CONTRACT_VERSION)?;
    // no setup
    Ok(Response::default())
}

#[cfg_attr(not(feature = "library"), entry_point)]
pub fn migrate(
    deps: DepsMut,
    _env: Env,
    _msg: MigrateMsg,
) -> Result<Response, ContractError> {
    let version: Version = CONTRACT_VERSION.parse()?;
    let storage_version: Version = get_contract_version(deps.storage)?.version.parse()?;
    if storage_version < version {
        set_contract_version(deps.storage, CONTRACT_NAME, CONTRACT_VERSION)?;
        // If state structure changed in any contract version in the way migration is needed, it
        // should occur here
    }
    Ok(Response::default())
}

#[cfg_attr(not(feature = "library"), entry_point)]
pub fn execute(
    _deps: DepsMut,
    _env: Env,
    _info: MessageInfo,
    _msg: ExecuteMsg,
) -> Result<Response, ContractError> {
    match _msg {
        ExecuteMsg::Subscribe(msg) => {
            execute_subscribe(_deps, _env, msg, &_info.sender)
        }
    }
}

pub fn execute_subscribe(
    deps:DepsMut,
    _env: Env,
    msg: SubscribeMsg,
    sender: &Addr,
) -> Result<Response, ContractError> {
    
    let record = Record{
        driver_address: sender.clone(),
        location: msg.location,
    };

    records().save(
            deps.storage,
            sender,
            &record,    
    )?;

    let res = Response::new().add_attributes(vec![
        ("action", "subscribe"),
        ("driver_address", record.driver_address.as_str()),
        ("location", record.location.as_str())]);

    Ok(res)
}

#[cfg_attr(not(feature = "library"), entry_point)]
pub fn query(deps: Deps, _env: Env, msg: QueryMsg) -> StdResult<Binary> {
    match msg {
        QueryMsg::List { location } => to_json_binary(&query_list(deps, vec![location])?),
        QueryMsg::ListMultiple {locations} => to_json_binary(&query_list(deps, locations)?), 
        QueryMsg::Details { address } =>to_json_binary(&query_details(deps, address)?),
    }
}

fn query_details(deps: Deps, address: String) -> StdResult<Record> {
    let addr = deps.api.addr_validate(&address)?;
    let record = records().load(deps.storage, &addr)?;
    Ok(record)
}

fn query_list(deps: Deps, locations: Vec<String>) -> StdResult<Vec<Record>> {
    let mut res = Vec::new();
    for loc in locations.iter() {
        let loc_items = records()
            .idx
            .location
            .prefix(loc.clone())
            .range(deps.storage, None, None, Order::Ascending)
            .map(|r| r.map(|(_,v)| v))
            .collect::<StdResult<Vec<Record>>>()?;
        res.extend(loc_items);
    }
    Ok(res)
}