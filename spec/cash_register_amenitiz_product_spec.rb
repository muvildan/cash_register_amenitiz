# frozen_string_literal: true

RSpec.describe CashRegisterAmenitiz::Product do
  let(:product) { CashRegisterAmenitiz::Product }

  # Check if the product attributes can be accessed using the product code
  describe '#check_product_data' do
    it 'check product data by product code' do
      aggregate_failures('verify data') do
        expect(product.name('GR1')).to eq('Green tea')
        expect(product.price('GR1')).to eq(3.11)
        expect(product.name('SR1')).to eq('Strawberry')
        expect(product.price('SR1')).to eq(5.00)
        expect(product.name('CF1')).to eq('Coffee')
        expect(product.price('CF1')).to eq(11.23)
        expect(product.name('TEST')).to eq('Test')
        expect(product.price('TEST')).to eq(10.00)
      end
    end
  end
end
