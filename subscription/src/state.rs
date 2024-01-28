use cosmwasm_schema::cw_serde;
use cosmwasm_std::{Addr};
use cw_storage_plus::{MultiIndex, Index, IndexList, IndexedMap};


#[cw_serde]
pub struct Record {
    pub driver_address: Addr,
    pub location: String,
}
     
pub struct RecordIndexes<'a> {
    pub location: MultiIndex<'a, String, Record, Addr>,
}

impl<'a> IndexList<Record> for RecordIndexes<'a> {
    fn get_indexes(&'_ self) -> Box<dyn Iterator<Item = &'_ dyn Index<Record>> + '_> {
        let v: Vec<&dyn Index<Record>> = vec![&self.location];
        Box::new(v.into_iter())
    }
}

pub fn records<'a>() -> IndexedMap<'a, &'a Addr, Record, RecordIndexes<'a>> {
    let indexes = RecordIndexes {
        location: MultiIndex::new(
            |_key, r| r.location.clone(),
            "records",
            "records__location",
        ),
    };
    IndexedMap::new("records", indexes)
}