module itemmarket::user {
    use std::string::{Self, String};
    use sui::object::{Self, UID};
    use sui::url::{Self, Url};
    use sui::object_table::{Self, ObjectTable}; 

    struct User has key, store {
        id: UID,
        name: String,
        address: String,
        img_url: Url,
    }

    public fun create_user(
        name: String,
        address: String,
        img_url: Url,
        users: &mut ObjectTable<UID, User>,
    ): User {
        let user = User {
            id: object::new(),
            name: name,
            address: address,
            img_url: img_url,
        };
        object_table::add(users, user.id, user);
        
        struct UserCreated has copy, drop {
            user_id: UID,
            name: String,
            address: String,
            img_url: Url,
        }

        public fun emit_user_created_event(user: &User) {
            event::emit(
                UserCreated {
                    user_id: user.id,
                    name: user.name,
                    address: user.address,
                    img_url: user.img_url,
                }
            );
        }

        emit_user_created_event(&user);

        user
    }

    public fun update_user(user: &mut User, new_name: String, new_address: String, new_img_url: Url) {
        user.name = new_name;
        user.address = new_address;
        user.img_url = new_img_url;

        struct UserUpdated has copy, drop {
            user_id: UID,
            new_name: String,
            new_address: String,
            new_img_url: Url,
        }

        public fun emit_user_updated_event(user: &User, new_name: String, new_address: String, new_img_url: Url) {
            event::emit(
                UserUpdated {
                    user_id: user.id,
                    new_name: new_name,
                    new_address: new_address,
                    new_img_url: new_img_url,
                }
            );
        }

        emit_user_updated_event(user, new_name, new_address, new_img_url);
    }

    public fun delete_user(user_id: UID, users: &mut ObjectTable<UID, User>) {
        object_table::delete(users, user_id);

        struct UserDeleted has copy, drop {
            user_id: UID,
        }

        public fun emit_user_deleted_event(user_id: UID) {
            event::emit(
                UserDeleted {
                    user_id: user_id,
                }
            );
        }

        emit_user_deleted_event(user_id);
    }
}
