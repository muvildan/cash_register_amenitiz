# frozen_string_literal: true

module CashRegisterAmenitiz
  # Class Product.
  #
  # TODO: Create good class documentation.
  #
  module Product
    module_function

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
        'price': 10
      }
    }.freeze

    # Get the product name.
    def price(product_code)
      INVENTORY[product_code.to_sym][:price]
    end

    # Get the product name.
    def name(product_code)
      INVENTORY[product_code.to_sym][:name]
    end
  end
end
