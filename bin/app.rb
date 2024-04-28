# frozen_string_literal: true

require 'colorize'
require 'tty-prompt'
require_relative '../lib/cash_register_amenitiz'

# StoreApp Class
class StoreApp
  def initialize
    @prompt = TTY::Prompt.new
    @cart = CashRegisterAmenitiz::Cart.new
    @product = CashRegisterAmenitiz::Product
  end

  def start_console
    welcome_message
    loop do
      cart_information
      choice = @prompt.select('What would you like to do?', cycle: true) do |menu|
        menu.choice 'Add a product to the cart'
        menu.choice 'Remove a product from the cart'
        menu.choice 'Checkout'
        menu.choice 'Exit app'
      end

      case choice
      when 'Add a product to the cart'
        add_product_menu
      when 'Remove a product from the cart'
        remove_products_menu
      when 'Checkout'
        checkout_menu
      when 'Exit app'
        exit_cart
      end
    end
  end

  private

  def product_map(items = nil)
    selected_items = items ? @product.inventory(items) : @product.inventory
    selected_items.map do |key, data|
      { key: key.to_s, name: items ? "#{data[:name]} (x#{items.count(key.to_s)})" : data[:name], value: key.to_s }
    end
  end

  def welcome_message
    display_ascii_art = File.read('../ascii-art.txt')
    puts display_ascii_art.colorize(:blue)
    puts "-Welcome to our store at Amenitiz!\n".colorize(color: :blue, mode: :bold)
  end

  def cart_information
    if @cart.items.any?
      show_products_in_cart
      show_cart_prices
    else
      empty_cart_message
    end
  end

  def show_products_in_cart
    product_names = product_map(@cart.items)
    product_list = product_names.map { |product| product[:name] }.join(', ')
    puts "Products in the Cart: #{product_list}".colorize(:light_magenta)
  end

  def show_cart_prices
    puts 'Full price: '.colorize(:light_red) + "#{@cart.full_price}€".colorize(color: :red, mode: :bold)
    puts 'Final price (with discounts): '.colorize(:light_green) +
         "#{@cart.total_price}€\n".colorize(color: :green, mode: :bold)
  end

  def empty_cart_message
    puts '(!) '.colorize(color: :yellow, mode: :bold) + "No products in the cart.\n".colorize(:cyan)
  end

  def add_product_menu
    product_code = @prompt.select('Select the product to add:', product_map)
    product_name = @product.name(product_code)
    @cart.add_product(product_code)
    puts "\n(+) ".colorize(color: :green, mode: :bold) +
         "Product #{product_name} - #{product_code} added to the cart.".colorize(:cyan)
  end

  def checkout_menu
    puts "\n-It will be #{@cart.total_price}€, please\n".colorize(:blue)
    option = @prompt.select('What would you like to do next?', cycle: true) do |menu|
      menu.choice 'Pay'
      menu.choice 'Remove products'
      menu.choice 'Nevermind'
    end
    case option
    when 'Pay'
      pay
    when 'Remove products'
      remove_products_menu
    end
  end

  def pay
    puts "\nYou paid ".colorize(:light_cyan) + "#{@cart.total_price}€\n".colorize(color: :cyan, mode: :bold)
    puts "-Thanks for buying at Amenitiz!\n".colorize(:blue)
    @cart.empty
  end

  def exit_cart
    puts "\n-Goodbye!\n".colorize(:blue)
    exit
  end

  def remove_products_menu
    return unless @cart.items.any?

    product_code = @prompt.select('Select the product to remove:', product_map(@cart.items))
    product_name = @product.name(product_code)
    puts "\n(-) ".colorize(color: :red, mode: :bold) +
         "Product #{product_name} - #{product_code} removed from the cart.".colorize(:cyan)
    @cart.remove_product(product_code)
  end
end

StoreApp.new.start_console
