# ItemMarket Smart Contract

Welcome to the ItemMarket smart contract repository! This repository contains the Move on SUI smart contract implementation for a simple marketplace where users can  sell, buy, create, update and delete items.

## Features

- Create and manage user profiles
- Add, update, and delete items for sale
- List all items available in the market

## Getting Started

Follow the steps below to set up and deploy the ItemMarket smart contract on the Move on SUI blockchain.

### Prerequisites

- Move on SUI development environment installed. Follow the [SUI Docs](https://docs.sui.io/) for installation instructions.

### Deployment

1. Clone this repository:

    ```bash
    git clone https://github.com/your-username/itemmarket.git
    cd itemmarket
    ```

2. Deploy the smart contract on the devnet:

    ```bash
    sui deploy src/itemmarket.move
    ```

    Make sure to save the contract address for future reference.

### Usage

Interact with the smart contract using the provided functions:

- Create a user profile: `create_user(name: String, address: String, img_url: Url)`
- Update user information: `update_user(user_id: UID, new_name: String, new_address: String, new_img_url: Url)`
- Delete a user profile: `delete_user(user_id: UID)`

- Create an item for sale: `create_item(name: String, title: String, owner: UID, price: u64)`
- Update item information: `update_item(item_id: UID, new_name: String, new_title: String, new_price: u64)`
- Delete an item: `delete_item(item_id: UID)`

- List all items in the market: `list_all_items()`
