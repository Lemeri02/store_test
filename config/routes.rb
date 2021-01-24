Rails.application.routes.draw do
  resources :stores do
    resources :products, shallow: true do
      collection do
        get :move_product
        get :sell_product
      end
    end
  end
end
