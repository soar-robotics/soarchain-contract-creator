#[cfg(not(feature = "library"))]

use cosmwasm_std::entry_point;
use cosmwasm_std::{
    to_binary, Addr, Binary, Deps, DepsMut, Env, MessageInfo, Response,
    StdResult, Uint128, BankMsg, coin};

use cw2::set_contract_version;

use crate::error::ContractError;
use crate::msg::{
    InstantiateMsg,
    CreateMsg, 
    ExecuteMsg,
    WithdrawMsg,
    QueryMsg,
    ListResponse,
    DetailsResponse
};

use crate::escrow::Escrow;
use crate::state::{all_escrow_ids, ESCROWS, BALANCES, State, STATE};

// version info for migration info
const CONTRACT_NAME: &str = "crates.io:escrow";
const CONTRACT_VERSION: &str = env!("CARGO_PKG_VERSION");

#[cfg_attr(not(feature = "library"), entry_point)]
pub fn instantiate(
    deps: DepsMut,
    _env: Env,
    info: MessageInfo,
    msg: InstantiateMsg,
) -> StdResult<Response> {

    let state = State {
        owner: info.sender.to_string(),
        denom: msg.denom
    };

    set_contract_version(deps.storage, CONTRACT_NAME, CONTRACT_VERSION)?;

    STATE.save(deps.storage, &state)?;

    Ok(Response::new()
        .add_attribute("method", "instantiate")
        .add_attribute("owner", info.sender.to_string())
        .add_attribute("denom", state.denom.to_string())
    )
}

#[cfg_attr(not(feature = "library"), entry_point)]
pub fn execute(
    deps: DepsMut,
    env: Env,
    info: MessageInfo,
    msg: ExecuteMsg,
) -> Result<Response, ContractError> {
    match msg {
        ExecuteMsg::Create(msg) => execute_create(deps, env, msg, &info.sender ),
        ExecuteMsg::Withdraw(msg)  => execute_withdraw(deps, env, info, msg),
        ExecuteMsg::Cancel{id} => execute_cancel(deps, env, id, info),
    }
}

pub fn execute_create(
    deps: DepsMut,
    _env: Env,
    msg: CreateMsg,
    sender: &Addr,
) -> Result<Response, ContractError> {
  
    let user_b_addr = deps.api.addr_validate(&msg.user_b)?;

    let escrow = Escrow::create(
        sender.clone(),
        user_b_addr,
        msg.amount,
        msg.lock,
    )?;

    // try to store it, fail if the id was already in use
    ESCROWS.update(deps.storage, &msg.id, |existing| match existing {
        None => Ok(escrow),
        Some(_) => Err(ContractError::AlreadyInUse {}),
    })?;

    let res = Response::new().add_attributes(vec![("action", "create"), ("id", msg.id.as_str())]);
    Ok(res)
}

pub fn execute_withdraw(
    deps: DepsMut,
    _env: Env,
    info: MessageInfo,
    msg: WithdrawMsg,
) -> Result<Response, ContractError> {
    // this fails if no escrow there
    let mut escrow = ESCROWS.load(deps.storage, &msg.id)?;

    if escrow.deposit.eq(&Uint128::new(0_u128)) {
        return Result::Err(ContractError::ZeroAmount {});
    }

    if escrow.closed {
        return Err(ContractError::Closed {});
    }

    escrow.unlock(info.sender.to_string(), msg.secret)?;

    escrow.close();
    
    ESCROWS.save(deps.storage, &msg.id, &escrow)?;

    BALANCES.update(
        deps.storage,
        &escrow.user_b,
        |balance: Option<Uint128>| -> StdResult<_> { Ok(balance.unwrap_or_default() + escrow.deposit) },
    )?;

    let u128_deposit_amount: u128 = escrow.deposit.u128();
    let state = STATE.load(deps.storage)?;

    let msg = BankMsg::Send {
        to_address: escrow.user_b.to_string(),
        amount: vec![coin(u128_deposit_amount, state.denom.to_string())],
    };

    

    let res = Response::new()
        .add_attribute("action", "withdraw")
        .add_attribute("from", info.sender)
        .add_attribute("to", escrow.user_b)
        .add_attribute("amount", escrow.deposit)
        .add_message(msg);
    Ok(res)
}

pub fn execute_cancel(
    deps: DepsMut,
    _env: Env,
    id: String,
    info: MessageInfo,
) -> Result<Response, ContractError> {
    // this fails is no escrow there
    let mut escrow = ESCROWS.load(deps.storage, &id)?;

    if escrow.closed {
        return Err(ContractError::Closed {  });
    }

    if info.sender != escrow.user_a {
        return Err(ContractError::InvalidUser { });
    }

    escrow.close();
    
    ESCROWS.save(deps.storage, &id, &escrow)?;

    let res = Response::new().add_attributes(vec![
        ("action", "cancel"),
        ("id", &id.as_str()),
    ]);
        
    Ok(res)
}

#[cfg_attr(not(feature = "library"), entry_point)]
pub fn query(deps: Deps, _env: Env, msg: QueryMsg) -> StdResult<Binary> {
    match msg {
        QueryMsg::List {} => to_binary(&query_list(deps)?),
        QueryMsg::Details { id } => to_binary(&query_details(deps, id)?),
    }
}

fn query_details(deps: Deps, id: String) -> StdResult<DetailsResponse> {
    let escrow = ESCROWS.load(deps.storage, &id)?;

    let details = DetailsResponse {
        id,
        user_a: escrow.user_a.to_string(),
        user_b: escrow.user_b.to_string(),
        deposit: escrow.deposit,
        lock: escrow.lock,
        closed: escrow.closed,
    };

    Ok(details)
}

fn query_list(deps: Deps) -> StdResult<ListResponse> {
    Ok(ListResponse {
        escrows: all_escrow_ids(deps.storage)?,
    })
}

