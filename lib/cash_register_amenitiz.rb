# frozen_string_literal: true

require_relative 'cash_register_amenitiz/version'
require_relative 'cash_register_amenitiz/cart'
require_relative 'cash_register_amenitiz/product'
require_relative 'cash_register_amenitiz/promotion'
require_relative 'cash_register_amenitiz/promotion/buy_one_get_one_free'
require_relative 'cash_register_amenitiz/promotion/discount_to_fixed_price'
require_relative 'cash_register_amenitiz/promotion/discount_to_fractioned_price'

module CashRegisterAmenitiz
  class Error < StandardError; end
  # Your code goes here...
end
