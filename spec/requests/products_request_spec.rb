require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe 'GET move_product' do
    let(:main_store) { FactoryBot.create(:store_with_balance) }
    let(:target_store) { FactoryBot.create(:store_with_balance) }
    let(:product) { FactoryBot.create(:product_with_price, store: main_store) }

    before(:each) do
      get "/stores/#{main_store.id}/products/move_product", params: { product_sku: "#{product.sku}", target_store_id: "#{target_store.id}", quantity: 1}
    end

    it 'changes the balance of the main store and the target store' do
      expect(main_store.reload.balance.amount).to eq(product.price.amount * 1)
      expect(target_store.reload.balance.amount).to eq(-(product.price.amount * 1))
    end

    it 'copies the product to a target store' do
      expect(target_store.reload.products.last.sku).to eq(product.sku)
    end

    it 'reduces the quantity of products in main store' do
      expect(main_store.reload.products.last.quantity).to eq(product.quantity - 1)
    end
  end

  describe 'GET sell_product' do
    let(:store) { FactoryBot.create(:store_with_balance) }
    let(:product) { FactoryBot.create(:product_with_price, store: store) }

    before(:each) do
      get "/stores/#{store.id}/products/sell_product", params: { product_sku: "#{product.sku}", quantity: 1 }
    end

    it 'reduces the quantity of products in store' do
      expect(store.reload.products.first.quantity).to eq(product.quantity - 1)
    end

    it 'the amount of products sold goes to the balance of the store' do
      expect(store.reload.balance.amount).to eq(product.price.amount * 1)
    end
  end
end
