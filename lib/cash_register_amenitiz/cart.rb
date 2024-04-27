# frozen_string_literal: true

module CashRegisterAmenitiz
  # Class Cart.
  #
  # TODO: Create good class documentation.
  #
  class Cart
    attr_reader :items

    # Initialize the cart with an empty array.
    def initialize
      @items = []
    end

    # Adds a product to the Cart.
    def add_product(product_code)
      @items << product_code
    end
  end
end
