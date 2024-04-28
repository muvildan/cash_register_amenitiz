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
      @product = Product
    end

    # Adds a product to the Cart.
    def add_product(product_code)
      @items << product_code
    end

    def remove_product(product_code)
      index = @items.index(product_code)
      @items.delete_at(index) if index
    end

    def total_price
      promotion = Promotion.new(@items, @product)
      no_promo, cart = promotion.total_promotion
      cart += no_promo.map { |product_code| @product.price(product_code) }.sum
      cart.round(2)
    end

    def full_price
      @items.map { |product_code| @product.price(product_code) }.sum.round(2)
    end

    def empty
      @items.clear
    end
  end
end
