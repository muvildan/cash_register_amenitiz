# frozen_string_literal: true

module CashRegisterAmenitiz
  # The Product class manages product information.
  #
  # Responsibilities:
  # - Provides access to product prices and names.
  # - Maintains an inventory of available products.
  #
  class Product
    # The INVENTORY hash contains product codes as keys, each with a nested hash
    # containing the product's name and price.
    INVENTORY = {
      'GR1': {
        'name': 'Green tea',
        'price': 3.11
      },
      'SR1': {
        'name': 'Strawberry',
        'price': 5.00
      },
      'CF1': {
        'name': 'Coffee',
        'price': 11.23
      },
      'TEST': {
        'name': 'Test',
        'price': 10.00
      }
    }.freeze

    # Returns the price of a product based on its product code.
    def self.price(product_code)
      INVENTORY[product_code.to_sym][:price]
    end

    # Returns the name of a product based on its product code.
    def self.name(product_code)
      INVENTORY[product_code.to_sym][:name]
    end

    # Returns an array of all available product codes.
    def self.list
      INVENTORY.keys.map(&:to_s)
    end

    # Returns the entire inventory hash or a filtered subset based on the provided list of product codes.
    def self.inventory(list = nil)
      list ? INVENTORY.select { |key, _| list.include?(key.to_s) } : INVENTORY
    end
  end
end
