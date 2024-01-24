use cosmwasm_std::StdError;
use thiserror::Error;

#[derive(Error, Debug, PartialEq)]
pub enum ContractError {
    #[error("{0}")]
    Std(#[from] StdError),

    #[error(transparent)]
    Escrow(#[from] EscrowError),

    #[error("Escrow id already in use")]
    AlreadyInUse {},

    #[error("Escrow is closed")]
    Closed {},

    #[error("Only escrow creator can cancel")]
    InvalidUser {},

    #[error("Amount was zero, must be positive")]
    ZeroAmount {},

    #[error("Sender is not the owner of the contract")]
    Unauthorized {},

    #[error("Insufficient Funds")]
    InsufficientFunds{},

}

#[derive(Error, Debug, PartialEq)]
pub enum EscrowError {
    #[error("Send some coins to create an escrow")]
    EmptyDeposit {},
    
    #[error("Match required deposit")]
    InvalidDeposit {},

    #[error("Account lock is not set")]
    NoLock {},

    #[error("Invalid Secret")]
    InvalidSecret {},

    #[error("Sender is not the owner of the contract")]
    Unauthorized {},
}