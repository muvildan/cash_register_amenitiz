# frozen_string_literal: true

RSpec.describe CashRegisterAmenitiz::Cart do
  let(:cart) { CashRegisterAmenitiz::Cart.new }

  # There should be a method to add products to the cart
  describe '#add_product' do
    it 'Adds a product to the cart' do
      cart.add_product('GR1')
      expect(cart.items).to eq(['GR1'])
    end
  end

  # There should be a method to remove products from the cart
  describe '#remove_product' do
    it 'Removes a product from the cart' do
      cart.add_product('GR1')
      cart.add_product('SR1')
      cart.remove_product('GR1')
      expect(cart.items).to eq(['SR1'])
    end
  end

  describe '#total_price' do
    # | GR1,GR1 | 3.11€ |
    it 'Calculates the pricing discount requested by the CEO' do
      cart.add_product('GR1') # 3.11
      cart.add_product('GR1') # 3.11
      # 3.11 + 0 = 3.11
      expect(cart.total_price).to eq(3.11)
    end
    # | SR1,SR1,GR1,SR1 | 16.61€ |
    it 'Calculates the pricing discount requested by the COO' do
      cart.add_product('SR1') # 5.00
      cart.add_product('SR1') # 5.00
      cart.add_product('GR1') # 3.11
      cart.add_product('SR1') # 5.00
      # 4.50 + 4.50 + 3.11 + 4.50 = 16.61
      expect(cart.total_price).to eq(16.61)
    end

    # | GR1,CF1,SR1,CF1,CF1 | 32.8€ |
    it 'Calculates the pricing discount requested by the VP of Engineering' do
      cart.add_product('GR1') # 3.11
      cart.add_product('CF1') # 11.23 - 3 = 8.23
      cart.add_product('SR1') # 5.00
      cart.add_product('CF1') # 11.23 - 3 = 8.23
      cart.add_product('CF1') # 11.23 - 3 = 8.23
      # 3.11 + 5.00 + 8.23 * 3 = 32.8
      expect(cart.total_price).to eq(32.8)
    end

    # | TEST,TEST,TEST | 15.00€ |
    it 'Calculates the pricing with fractional discount' do
      cart.add_product('TEST') # 10.00
      cart.add_product('TEST') # 10.00
      cart.add_product('TEST') # 10.00
      # 10.00 * 0.5 * 3 = 15
      expect(cart.total_price).to eq(15)
    end

    # NEW TESTS FOR THE CODE REVIEW

    # | CF1,CF1 | 32.46€ |
    it 'NEW promo: calculates the total pricing without discounts if the count is not >= activation' do
      cart.add_product('CF2') # 20.00
      cart.add_product('CF2') # 20.00
      # 20.00 * 2 = 40.00
      expect(cart.total_price).to eq(40.00)
    end

    # | TEST,CF1,CF1 | 32.46€ |
    it 'NEW promo: calculates the total pricing with discount combining different products applicable' do
      cart.add_product('CF1') # 11.23 - 3 = 8.23
      cart.add_product('CF2') # 20.00 - 3 = 17.00
      cart.add_product('CF2') # 20.00 - 3 = 17.00
      # 8.23 + (17.00 * 2) = 42.23
      expect(cart.total_price).to eq(42.23)
    end

    # | TEST,CF1,CF1 | 32.46€ |
    it 'NEW promo: calculates the total pricing with discount for several applicable products' do
      cart.add_product('CF1') # 11.23 - 3 = 8.23
      cart.add_product('CF1') # 11.23 - 3 = 8.23
      cart.add_product('CF1') # 11.23 - 3 = 8.23
      cart.add_product('CF2') # 20.00 - 3 = 17.00
      cart.add_product('CF2') # 20.00 - 3 = 17.00
      # 8.23 * 3 + 17.00 * 2 = 58.69
      expect(cart.total_price).to eq(58.69)
    end

    # | TEST,CF1,CF1 | 32.46€ |
    it 'NEW promo: calculates the total pricing with and wihtout applicable discounts' do
      cart.add_product('TEST') # 10.00
      cart.add_product('CF1') # 11.23 - 3 = 8.23
      cart.add_product('CF1') # 11.23 - 3 = 8.23
      cart.add_product('CF1') # 11.23 - 3 = 8.23
      cart.add_product('CF2') # 20.00 - 3 = 17.00
      cart.add_product('CF2') # 20.00 - 3 = 17.00
      # 10.00 + 8.23 * 3 + 17.00 * 2 = 68.69
      expect(cart.total_price).to eq(68.69)
    end
  end
end
