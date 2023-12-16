module itemmarket::item {
    use std::string::{Self, String};
    use sui::object::{Self, UID};
    use sui::object_table::{Self, ObjectTable};

    struct Item has key, store {
        id: UID,
        name: String,
        title: String,
        owner: UID,
        price: u64,
    }

    public fun create_item(
        name: String,
        title: String,
        owner: UID,
        price: u64,
        items: &mut ObjectTable<UID, Item>,
    ): Item {
        let item = Item {
            id: object::new(),
            name: name,
            title: title,
            owner: owner,
            price: price,
        };
        object_table::add(items, item.id, item);
        item
    }

    public fun update_item(item: &mut Item, new_name: String, new_title: String, new_price: u64) {
        item.name = new_name;
        item.title = new_title;
        item.price = new_price;
    }

    public fun delete_item(item_id: UID, items: &mut ObjectTable<UID, Item>) {
        object_table::delete(items, item_id);
    }

    struct ItemUpdated has copy, drop {
        item_id: UID,
        new_name: String,
        new_title: String,
        new_price: u64,
    }

    struct ItemDeleted has copy, drop {
        item_id: UID,
    }

    public fun emit_item_updated_event(item: &Item, new_name: String, new_title: String, new_price: u64) {
        event::emit(
            ItemUpdated {
                item_id: item.id,
                new_name: new_name,
                new_title: new_title,
                new_price: new_price,
            }
        );
    }

    public fun emit_item_deleted_event(item_id: UID) {
        event::emit(
            ItemDeleted {
                item_id: item_id,
            }
        );
    }
}
