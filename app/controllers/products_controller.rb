class ProductsController < ApplicationController
  def index
    # Query sample
    # localhost:3000/stores/1/products
    @products = Product.where(store_id: permit_params[:store_id])

    render json: @products, include: :price
  end

  def show
    # Query sample
    # localhost:3000/products/1
    @product = Product.find(permit_params[:id])

    render json: @product, include: :price
  end

  def move_product
    # Query sample
    # localhost:3000/stores/1/products/move_product?product_sku=SKU69&target_store_id=2&quantity=1
    @product = MoveProduct.new.call(
      main_store_id: permit_params[:store_id],
      product_sku: permit_params[:product_sku],
      target_store_id: permit_params[:target_store_id],
      quantity: permit_params[:quantity]
    )

    render json: @product, include: :price
  end

  def sell_product
    # Query sample
    # localhost:3000/stores/1/products/sell_product?product_sku=SKU69&quantity=1
    @product = SellProduct.new.(
      store_id: permit_params[:store_id],
      product_sku: permit_params[:product_sku],
      quantity: permit_params[:quantity]
    )

    # @product = product.value_or("Something went wrong!")

    render json: @product, include: :price
  end

  private

  def permit_params
    params.permit(:id, :store_id, :product_sku, :target_store_id, :quantity)
  end
end
