# frozen_string_literal: true

module CashRegisterAmenitiz
  # The Promotion class manages product promotions and discounts.
  #
  # Responsibilities:
  # - Calculates total promotion price based on specific rules.
  # - Handles buy-one-get-one-free and fixed/fractional discounts.
  #
  class Promotion
    attr_reader :items, :product

    # Initializes a new Promotion instance.
    #
    # @param items [Array<String>] An array of product codes.
    # @param product [Product] The associated product.
    def initialize(items, product)
      @items = items
      @no_promo = items.dup
      @product = product
    end

    # Calculates the total promotion price.
    #
    # @return [Array] An array containing the remaining items without promotions
    #   and the total promotion price.
    def total_promotion
      total_price = 0.0
      total_price += buy_one_get_one_free(@items, 'GR1')
      total_price += discount(@items, ['SR1'], 3, 0.50, 'fixed')
      total_price += discount(@items, ['CF1', 'CF2'], 3, 3.00, 'fixed')
      total_price += discount(@items, ['TEST'], 3, 2/4r, 'fractional')
      [@no_promo, total_price]
    end

    private

    # Calculates the price for buy-one-get-one-free promotion.
    #
    # @param items [Array<String>] An array of product codes.
    # @param product_code [String] The product code to apply the promotion.
    # @return [Float] The calculated price.
    def buy_one_get_one_free(items, product_code)
      units = items.count(product_code)
      price = Product.price(product_code)
      update_no_promo(product_code)
      units.odd? ? (units - 1) * (price * 0.5) + price : units * (price * 0.5)
    end

    # Calculates the price for fixed or fractional discount.
    #
    # @param items [Array<String>] An array of product codes.
    # @param product_codes [Array] The product code to apply the discount.
    # @param activation [Integer] The minimum units required for the discount.
    # @param discount [Float] The discount amount (fixed or fractional).
    # @param type [String] The discount type ('fixed' or 'fractional').
    # @return [Float] The calculated price.sd
    def discount(items, product_codes, activation, discount, type = 'fixed')
      total_units = product_codes.sum { |code| items.count(code) }

      return 0 unless total_units >= activation

      product_codes.map do |code|
        units = items.count(code)
        product_price = Product.price(code)
        discounted_price = type == 'fixed' ? (product_price - discount) : product_price * discount
        update_no_promo(code)
        units * discounted_price
      end.sum
    end

    # Removes the promoted item from the no-promo list.
    #
    # @param product_code [String] The product code to remove.
    def update_no_promo(product_code)
      @no_promo.delete_if { |item| item == product_code }
    end
  end
end
