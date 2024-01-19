use schemars::JsonSchema;
use serde::{Deserialize, Serialize};

// use k256::{
//     ecdsa::SigningKey,              
//     elliptic_curve::sec1::ToEncodedPoint,
// };

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
    /// lock is the public key that guards the deposit. 
    /// the corresponding private key is necessary to withdraw.
    pub lock: String,
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
        lock: &str,
    ) -> Result<Self,EscrowError> {
        
        if deposit.is_zero() {
            return Err(EscrowError::EmptyDeposit {});
        }

        Ok(Escrow{
            user_a,
            user_b,
            deposit,
            lock: lock.to_string(),
            closed: false,
        })
    }

    /// Returns an EscrowError:InvalidSecret if the secret is invalid
    pub fn unlock(&mut self, escrow_lock: String, secret:&str) -> Result<(), EscrowError> {        
        let private_key = hex::decode(secret);
        if private_key.is_err() {
            return Err(EscrowError::InvalidSecret {  });
        }

        if escrow_lock == self.lock {
            return Ok(());
        }

        return Err(EscrowError::InvalidSecret { });
    }

    /// close sets the closed flag to true 
    /// we can only close if the payout has already been computed
    /// which indireclty ensures that the escrow is in a closeable 
    /// state
    pub fn close(&mut self) {
        self.closed = true;
    }
}