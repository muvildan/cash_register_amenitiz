# frozen_string_literal: true

module CashRegisterAmenitiz
  # Class Promotion.
  #
  # TODO: Create good class documentation.
  #
  #
  class Promotion
    attr_reader :items, :product

    def initialize(items, product)
      @items = items
      @no_promo = items
      @product = product
    end

    def total_promotion
      total_price = 0.0
      total_price += buy_one_get_one_free(@items, 'GR1')
      total_price += discount(@items, 'SR1', 3, 4.50, 'fixed')
      total_price += discount(@items, 'CF1', 3, 2/3r, 'fractional')
      [@no_promo, total_price]
    end

    private

    def buy_one_get_one_free(items, product_code)
      units = items.count(product_code)
      price = Product.price(product_code)
      update_no_promo(product_code)
      units.odd? ? (units - 1) * (price * 0.5) + price : units * (price * 0.5)
    end

    def discount(items, product_code, activation, discount, type = 'fixed')
      units = items.count(product_code)
      product_price = Product.price(product_code)
      price = type == 'fixed' ? discount : product_price * discount
      update_no_promo(product_code)
      units >= activation ? (units * price) : units * product_price
    end

    def update_no_promo(product_code)
      @no_promo.delete_if { |item| item == product_code }
    end
  end
end
