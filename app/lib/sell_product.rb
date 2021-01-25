require 'dry/monads'
require 'dry/monads/do'

class SellProduct
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)

  def call(store_id:, product_sku:, quantity:)
    quantity = quantity.to_f

    store = yield find_store(store_id)
    product = yield find_product(store_id: store_id, product_sku: product_sku)

    if valid?(quantity) && (product.quantity >= quantity)
      total_amount = product.price.amount * quantity

      new_product_quantity = product.quantity - quantity

      new_store_balance = store.balance.amount + total_amount

      store.balance.update(amount: new_store_balance)
      product.update(quantity: new_product_quantity)
      Success(product)
    else
      Failure('Error: Inncorrect quantity or product unavailable')
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
      Failure("Product with sku:#{product_sku} in store with id: #{store_id} not found")
    end
  end
end
