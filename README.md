# Cash Register Application

## Table of Contents
- [Introduction](#introduction)
- [Objective](#objective)
- [App](#app)
  - [Products](#products)
  - [Promotions](#promotions)
  - [Usage](#usage)
  - [TDD](#tdd)

## Introduction
Welcome to the Cash Register Application README! This application is designed to serve as a simple, yet powerful tool for managing purchases, calculating totals, and applying dynamic pricing rules. Whether you're a small business owner, a developer looking to learn more about software design, or simply curious about how pricing algorithms work, this application is for you.

## Objective
The primary objective of this project is to develop a Cash Register Application that meets the following criteria:
- Simple and easy to use.
- Readable and maintainable.
- Easily extendable to accommodate future changes.
- Covered by tests and developed following Test-Driven Development (TDD) methodology.
- As a personal objective, I decided to build this app in Ruby.


## App
### Products
In this application, we assume the existence of three (+1 for testing purposes) products, each with a unique product code, name, and price:
- Green Tea (GR1) - 3.11€
- Strawberries (SR1) - 5.00€
- Coffee (CF1) - 11.23€
- TEST (Test) - 10.00€

The `Product` class encapsulates functionality related to product information, such as retrieving prices, names, and listing all available product codes. It is designed to provide methods for accessing product information from the inventory. Here's an overview of its structure:
- **Constants**:
  - `INVENTORY`: A hash containing product information, including names and prices.
- **Class Methods**:
  - `price`: Retrieves the price of a product based on its code.
  - `name`: Retrieves the name of a product based on its code.
  - `list`: Lists all available product codes.
  - `inventory`: Retrieves the entire inventory or a filtered subset based on provided product codes.

### Promotions
To meet the preferences of key stakeholders, the following special pricing rules are implemented:
- CEO's Rule: **Buy-one-get-one-free** offer on Green Tea (GR1):
    - If you buy one package of Green Tea, you get another one for free.
- COO's Rule: **Fixed price discount** for bulk purchases of Strawberries (SR1):
  - If you buy **3 or more** Strawberries, the price per unit drops to €4.50 each.
- VP of Engineering's Rule: **Fractional price discount** for bulk purchases of Coffee (CF1):
  - If you buy **3 or more** Coffees, the price per unit drops to 2/3 of the original price.

The heart of the Cash Register Application lies in the `Promotion` class, responsible for applying special pricing rules to the items in the cart. It is designed to encapsulate the logic for applying various promotions to items in the cart. Here's an overview of its structure:
- **Attributes**: 
  - `items`: Represents the list of items in the cart.
  - `product`: Represents the product associated with the promotion.
- **Methods**:
  - `initialize`: Initializes a new instance of the `Promotion` class with the given items and product.
  - `total_promotion`: Calculates the total price of items in the cart after applying promotions.
  - `buy_one_get_one_free`: Implements the buy-one-get-one-free promotion for a specific product.
  - `discount`: Implements the discount promotions (both fixed and fractional) for a specific product based on quantity purchased.
  - `update_no_promo`: Updates the list of items without any promotions applied.

### Usage
If you'd like to use this app, follow these steps:
1. Clone this repository to your machine
2. Choose a rather medium to large terminal windows size for a better experience!
2. Navigate to the root of the project and run the following commands:
```
$ bundle
$ cd bin
$ Ruby app.rb
```
3. Enjoy!
You can now navigate the app and: 
    - Add items to your cart.
    - Remove items from your cart.
    - View the current items of your cart.
    - Check the price with and without promotions being applied.
    - Checkout and pay, or stay and keep shopping.
    - Exit the app.

Hope you liked it!
### TDD
If you'd like to run the provided tests:
1. Navigate to the root of the project and run the following command:
```
$ rspec
```
The following test scenarios are provided to ensure the correct functioning of the application:
1. **Check Product Data**
    - **Description**: There should be four different product types, and each of them should have a code, a name, and a price.
    - **Test**: 
        - Check that it exists a product with the code 'GR1' named 'Green Tea'.
        - Check that it exists a product with the code 'GR1' priced €3.11.
        - [...]
1. **Method to Add Products to the Cart:**
   - **Description:** There should be a method to add products to the cart.
   - **Test:**
     - Add a product with code 'GR1' to the cart.
     - **Expected result:** The cart should contain only `['GR1']`.

2. **Method to Remove Products from the Cart:**
   - **Description:** There should be a method to remove products from the cart.
   - **Test:**
     - Add products 'GR1' and 'SR1' to the cart.
     - Remove product 'GR1' from the cart.
     - **Expected result:** The cart should contain only `['SR1']`.

3. **Total Price Calculation (CEO Discount):**
   - **Description:** Calculate the pricing discount requested by the CEO.
   - **Test:**
     - Add product 'GR1' twice to the cart (total price: €3.11).
     - **Expected result:** Total price should be €3.11.

4. **Total Price Calculation (COO Discount):**
   - **Description:** Calculate the pricing discount requested by the COO.
   - **Test:**
     - Add products 'SR1' (twice) and 'GR1' to the cart (total price: €16.61).
     - **Expected result:** Total price should be €16.61.

5. **Total Price Calculation (VP of Engineering Discount):**
   - **Description:** Calculate the pricing discount requested by the VP of Engineering.
   - **Test:**
     - Add products 'GR1', 'CF1', 'SR1', 'CF1', and 'CF1' to the cart (total price: €30.57).
     - **Expected result:** Total price should be €30.57.

6. **Total Price Calculation (General Test):**
   - **Description:** Calculate the pricing with and without discount.
   - **Test:**
     - Add products 'TEST', 'CF1', and 'CF1' to the cart (total price: €32.46).
     - **Expected result:** Total price should be €32.46.
