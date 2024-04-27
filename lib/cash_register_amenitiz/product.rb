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
        'price': 3.11,
        'promotion': 'buy_one_get_one_free'
      },
      'SR1': {
        'name': 'Strawberry',
        'price': 5.00,
        'promotion': 'discount_to_fixed_price'
      },
      'CF1': {
        'name': 'Coffee',
        'price': 11.23,
        'promotion': 'discount_to_fractioned_price'
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

    # Get the product promotion.
    def promotion(product_code)
      INVENTORY[product_code.to_sym][:promotion]
    end
  end
end
