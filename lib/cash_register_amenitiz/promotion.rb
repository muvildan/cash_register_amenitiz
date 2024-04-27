# frozen_string_literal: true

module CashRegisterAmenitiz
  # Class Promotion.
  #
  # TODO: Create good class documentation.
  #
  #
  class Promotion
    PROMOTION = {
      'discount_to_fixed_price': {
        'product': {
          'SR1': {
            'activation': 3,
            'fixed_price': 4.50
          }
        }
      },
      'discount_to_fractioned_price': {
        'product': {
          'CF1': {
            'activation': 3,
            'fractioned_price': 2/3r
          }
        }
      }
    }.freeze

    attr_reader :items, :product

    def initialize(items, product)
      @items = items
      @product = product
    end

    def total_promotion
      total_price = 0.0
      check_promotions(@items).each do |product_code, promotion_type|
        promotion = create(promotion_type, @items.select { |item| item == product_code }, @product)
        total_price += promotion.apply_promotion
      end
      total_price
    end

    private

    def check_promotions(items)
      promotions = {}
      items.uniq.each do |product_code|
        promotion_type = @product.promotion(product_code)
        promotions[product_code] = promotion_type if promotion_type
      end
      promotions
    end

    def create(promotion_type, items, product)
      promotion_class = get_promotion_class(promotion_type)
      activation, price = get_promotion_details(promotion_type, items)
      params = [items, product, activation, price].compact
      promotion_class.new(*params)
    end

    def get_promotion_class(promotion_type)
      promotion_class_name = promotion_type.split('_').map(&:capitalize).join('')
      promotion_class = CashRegisterAmenitiz::Promotion.const_get(promotion_class_name)
      raise ArgumentError, "Unknown promotion type: #{promotion_type}" unless promotion_class

      promotion_class
    end

    def get_promotion_details(promotion_type, items)
      return unless PROMOTION.key?(promotion_type.to_sym)

      product_details = PROMOTION[promotion_type.to_sym][:product][items.first.to_sym]
      activation = product_details[:activation]
      price = product_details[:fixed_price] || product_details[:fractioned_price]
      [activation, price]
    end
  end
end
