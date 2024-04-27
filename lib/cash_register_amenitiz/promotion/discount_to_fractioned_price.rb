# frozen_string_literal: true

module CashRegisterAmenitiz
  class Promotion
    # DiscountToFractionedPrice Class
    class DiscountToFractionedPrice < Promotion
      def initialize(items, product, activation, fractioned_price)
        super(items, product)
        @product_code = items.first
        @activation = activation
        @fractioned_price = fractioned_price
      end

      def apply_promotion
        units = @items.count(@product_code)
        price = @product.price(@product_code)

        units >= @activation ? (units * (price * @fractioned_price)) : units * price
      end
    end
  end
end
