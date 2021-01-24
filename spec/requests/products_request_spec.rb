require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe 'GET move_product' do
    before(:each) do
      @main_store = FactoryBot.create(:store_with_balance)
      @target_store = FactoryBot.create(:store_with_balance)
      @product = FactoryBot.create(:product_with_price, store: @main_store)

      get "/stores/#{@main_store.id}/products/move_product",
          params: { product_sku: "#{@product.sku}",
                    target_store_id: "#{@target_store.id}", quantity: 2 }
    end

    it 'changes the balance of the main store and the target store' do
      expect(@main_store.reload.balance.amount).to eq(@product.price.amount * 2)
      expect(@target_store.reload.balance.amount).to eq(-(@product.price.amount * 2))
    end

    it 'copies the product to a target store' do
      expect(@target_store.reload.products.last.sku).to eq(@product.sku)
    end

    it 'reduces the quantity of products in main store' do
      expect(@main_store.reload.products.last.quantity).to eq(@product.quantity - 2)
    end
  end

  describe 'GET sell_product' do
    before(:each) do
      @store = FactoryBot.create(:store_with_balance)
      @product = FactoryBot.create(:product_with_price, store: @store)

      get "/stores/#{@store.id}/products/sell_product",
          params: { product_sku: "#{@product.sku}", quantity: 2 }
    end

    it 'reduces the quantity of products in store' do
      expect(@store.reload.products.first.quantity).to eq(@product.quantity - 2)
    end

    it 'the amount of products sold goes to the balance of the store' do
      expect(@store.reload.balance.amount).to eq(@product.price.amount * 2)
    end
  end





  # it "It selling product less than 0" do
  #   byebug
  # end

  # it "Перенос весь товар целиком" do
  # end

  # it "Перенос весь товар целиком" do
  # end
end
