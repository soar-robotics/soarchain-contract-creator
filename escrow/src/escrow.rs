use schemars::JsonSchema;
use serde::{Deserialize, Serialize};

use cosmwasm_std::{Addr, Uint128};

use crate::error::EscrowError;

#[derive(Serialize, Deserialize, JsonSchema, Clone, PartialEq, Debug)]
pub struct Escrow {
    /// user_a creates the escrow
    pub user_a: Addr,
    /// user_b is the counterparty
    pub user_b: Addr,
    /// deposit are the funds locked in escrow
    pub deposit: Uint128,
    /// lock is the f2a key (digit) that guards the deposit. 
    /// the corresponding f2a key is necessary to withdraw.
    pub lock: Uint128,
    /// close indicates whether the escrow is closed and already settled
    /// if this value is true, it is assumed that all payouts have already
    /// been settled
    pub closed: bool,
}

impl Escrow {
    pub fn create(
        user_a: Addr,
        user_b: Addr,
        deposit: Uint128,
        lock: Uint128,
    ) -> Result<Self,EscrowError> {
        
        if deposit.is_zero() {
            return Err(EscrowError::EmptyDeposit {});
        }

        Ok(Escrow{
            user_a,
            user_b,
            deposit,
            lock: lock,
            closed: false,
        })
    }

    /// Returns an EscrowError:InvalidSecret if the secret is invalid
    pub fn unlock(&mut self, owner: String, secret: Uint128) -> Result<(), EscrowError> {        

        if self.user_a != owner.to_string() {
            return Err(EscrowError::InvalidUnlockOwner { });
        }

        if self.lock != secret {
            return Err(EscrowError::InvalidSecret { });
        }

        return Ok(());
       
    }

    /// close sets the closed flag to true 
    /// we can only close if the payout has already been computed
    /// which indireclty ensures that the escrow is in a closeable 
    /// state
    pub fn close(&mut self) {
        self.closed = true;
    }
}