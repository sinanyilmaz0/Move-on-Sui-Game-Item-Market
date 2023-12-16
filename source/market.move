module itemmarket::market {
    use std::string::{Self, String};
    use sui::object::{Self, UID};
    use sui::object_table::{Self, ObjectTable}; 
    use sui::coin::{Self, Coin};

    struct User has key, store {
        id: UID,
        name: String,
        address: String,
    }

    struct Item has key, store {
        id: UID,
        name: String,
        title: String,
        owner: UID,
        price: u64,
    }

    struct ItemMarket has key, store {
        items: ObjectTable<u64, Item>,
    }

    public fun list_all_items(itemmarket: &ItemMarket): Vec<Item> {
        object_table::values(&itemmarket.items).collect()
    }

    public fun sell_item(
        itemmarket: &mut ItemMarket,
        seller_id: UID,
        item_id: UID,
        price: u64,
    ) {
        let item = object_table::borrow_mut(&mut itemmarket.items, item_id);
        assert!(item.owner == seller_id, "Not the owner of the item");

        item.price = price;
        item.owner = UID::default(); 

        object_table::add(&mut itemmarket.items, item_id, item);
    }

    public fun buy_item(
        itemmarket: &mut ItemMarket,
        buyer_id: UID,
        item_id: UID,
        payment: Coin,
    ) {
        let item = object_table::borrow_mut(&mut itemmarket.items, item_id);
        assert!(item.owner != UID::default(), "Item not available for purchase");

        let value = coin::value(&payment);
        assert!(value >= item.price, "Insufficient funds to buy the item");
        item.owner = buyer_id;

        object_table::add(&mut itemmarket.items, item_id, item);
    }
}
