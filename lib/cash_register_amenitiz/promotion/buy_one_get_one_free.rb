# frozen_string_literal: true

module CashRegisterAmenitiz
  class Promotion
    # BuyOneGetOneFree Class
    class BuyOneGetOneFree < Promotion
      def initialize(items, product)
        super(items, product)
        @product_code = items.first
      end

      def apply_promotion
        units = @items.count(@product_code)
        price = @product.price(@product_code)
        units.odd? ? (units - 1) * (price * 0.5) + price : units * (price * 0.5)
      end
    end
  end
end
