# frozen_string_literal: true

module CashRegisterAmenitiz
  #  The Cart class manages the user's items within the shopping cart.
  #
  # Responsibilities:
  # - Adding and removing products from the cart.
  # - Clearing the cart.
  # - Calculating total prices (with and without promotions).
  #
  class Cart
    attr_reader :items, :product

    # Init
    def initialize
      @items = [] # Initialize an empty cart
      @product = Product # Reference to the Product class
    end

    # Adds a product to the cart.
    #
    # @param product_code [String] The code of the product to add.
    def add_product(product_code)
      @items << product_code
    end

    # Removes a product from the cart.
    #
    # @param product_code [String] The code of the product to remove.
    def remove_product(product_code)
      index = @items.index(product_code)
      @items.delete_at(index) if index
    end

    # Calculates the total price of items in the cart,
    # considering any applicable promotions.
    def total_price
      promotion = Promotion.new(@items, @product)
      no_promo, cart = promotion.total_promotion
      cart += no_promo.map { |product_code| @product.price(product_code) }.sum
      cart.round(2)
    end

    # Calculates the full price (without promotions) of items in the cart.
    def full_price
      @items.map { |product_code| @product.price(product_code) }.sum.round(2)
    end

    # Empties the cart by removing all items.
    def empty
      @items.clear
    end
  end
end
