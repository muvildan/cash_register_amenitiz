# frozen_string_literal: true

module CashRegisterAmenitiz
  class Promotion
    # DiscountToFixedPrice Class
    class DiscountToFixedPrice < Promotion
      def initialize(items, product, activation, fixed_price)
        super(items, product)
        @product_code = items.first
        @activation = activation
        @fixed = fixed_price
      end

      def apply_promotion
        units = @items.count(@product_code)
        price = @product.price(@product_code)

        units >= @activation ? (units * @fixed) : units * price
      end
    end
  end
end
