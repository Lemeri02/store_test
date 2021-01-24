require 'dry/monads'
require 'dry/monads/do'

class MoveProduct
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)

  def call(main_store_id:, product_sku:, target_store_id:, quantity:)
    quantity = quantity.to_f

    main_store = yield find_store(main_store_id)
    main_store_product = yield find_product(store_id: main_store_id, product_sku: product_sku)
    target_store = yield find_store(target_store_id)

    return Failure('Error: Target store should be different') if main_store == target_store

    if valid?(quantity) && (main_store_product.quantity >= quantity)
      total_amount = main_store_product.price.amount * quantity

      main_store_new_balance = main_store.balance.amount + total_amount
      target_store_new_balance = target_store.balance.amount - total_amount

      main_store.balance.update(amount: main_store_new_balance)
      target_store.balance.update(amount: target_store_new_balance)

      new_product_quantity = main_store_product.quantity - quantity

      main_store_product.update(quantity: new_product_quantity)

      target_store_product = target_store.products.find_or_create_by(sku: main_store_product.sku) do |new_product|
        new_product.name = main_store_product.name
        new_product.quantity = 0
        Price.create(product: new_product, amount: main_store_product.price.amount, currency: main_store_product.price.currency)
      end

      target_store_product.update(quantity: target_store_product.quantity + quantity)

      Success(target_store_product)
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
      Failure("Product with sku: #{product_sku} in store with id: #{store_id} not found")
    end
  end
end
