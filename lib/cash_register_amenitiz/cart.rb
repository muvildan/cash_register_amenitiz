# frozen_string_literal: true

module CashRegisterAmenitiz
  # Class Cart.
  #
  # TODO: Create good class documentation.
  #
  class Cart
    attr_reader :items, :product

    # Initialize the cart with an empty array.
    def initialize
      @items = []
      @product = CashRegisterAmenitiz::Product
    end

    # Adds a product to the Cart.
    def add_product(product_code)
      @items << product_code
    end

    def total_price
      promotion = CashRegisterAmenitiz::Promotion.new(@items, @product)
      promotion.total_promotion.round(2)
    end
  end
end
