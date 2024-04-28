# frozen_string_literal: true

RSpec.describe CashRegisterAmenitiz::Cart do
  let(:cart) { CashRegisterAmenitiz::Cart.new }

  # There should be a method to add products to the cart
  describe '#add_product' do
    it 'adds a product to the cart' do
      cart.add_product('GR1')
      expect(cart.items).to eq(['GR1'])
    end
  end

  describe '#total_price' do
    # | GR1,GR1 | 3.11€ |
    it 'calculates the pricing discount requested by the CEO' do
      cart.add_product('GR1') # 3.11
      cart.add_product('GR1') # 3.11
      # 3.11 + 0 = 3.11
      expect(cart.total_price).to eq(3.11)
    end
    # | SR1,SR1,GR1,SR1 | 16.61€ |
    it 'calculates the pricing discount requested by the COO' do
      cart.add_product('SR1') # 5.00
      cart.add_product('SR1') # 5.00
      cart.add_product('GR1') # 3.11
      cart.add_product('SR1') # 5.00
      # 4.50 + 4.50 + 3.11 + 4.50 = 16.61
      expect(cart.total_price).to eq(16.61)
    end
    # | GR1,CF1,SR1,CF1,CF1 | 30.57€ |
    it 'calculates the pricing discount requested by the VP of Engineering' do
      cart.add_product('GR1') # 3.11
      cart.add_product('CF1') # 11.23
      cart.add_product('SR1') # 5.00
      cart.add_product('CF1') # 11.23
      cart.add_product('CF1') # 11.23
      # 3.11 + 5.00 + 7.489 * 3 = 30.57
      expect(cart.total_price).to eq(30.57)
    end

    # | TEST,CF1,CF1 | 32.46€ |
    it 'calculates the pricing with and wihtout discount' do
      cart.add_product('TEST') # 10.00
      cart.add_product('CF1') # 11.23
      cart.add_product('CF1') # 11.23
      # 10.00 + 11.23 + 11.23 * 3 = 32.46
      expect(cart.total_price).to eq(32.46)
    end
  end
end
