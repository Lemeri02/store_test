class SellProduct
  include Dry::Monads[:result]

  def call(store_id:, product_sku:, quantity:)
    find_store(store_id).bind do |store|
      find_product(store_id: store_id, product_sku: product_sku).fmap do |product|
        quantity = quantity.to_f

        if valid?(quantity) && (product.quantity >= quantity)
          cost = product.price.amount * quantity

          new_quantity = product.quantity - quantity

          new_store_balance = store.balance.amount + cost

          store.balance.update(amount: new_store_balance)
          product.update(quantity: new_quantity)
          Success(product)
        else
          Failure('Error: Inncorrect quantity or product unavailable')
        end
      end
    end
  end

  private

  def valid?(quantity)
    quantity.positive? && quantity.is_a?(Numeric)
  end

  def find_store(id)
    store = Store.find_by(id: id)

    if store
      Success(store)
    else
      Failure('Store not found')
    end
  end

  def find_product(store_id:, product_sku:)
    product = Product.find_by(store_id: store_id, sku: product_sku)

    if product
      Success(product)
    else
      Failure("Product with id: #{product_id} in store with id: #{store_id} not found")
    end
  end
end
