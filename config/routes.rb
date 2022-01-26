Rails.application.routes.draw do

  devise_for :users
  root "products#index"

  resources :users do
    resources :products
  end
  resources :products, only: [:index, :show]
  resources :comments


  post '/products/add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'
  delete '/products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'

  post '/apply_coupon', to: 'checkout#apply_coupon', as: 'apply_coupon'

  get '/carts', to: 'carts#index', as: 'cart_index'
  post '/carts/set_orders', to: 'carts#set_orders', as: 'set_orders'

  post '/carts/inc_in_cart/:id', to: 'carts#inc_in_cart', as: 'inc_in_cart'
  post '/carts/dec_in_cart/:id', to: 'carts#dec_in_cart', as: 'dec_in_cart'
  get '/search', to: 'products#search', as: 'search_of_product'
  post 'checkout/create', to: 'checkout#create'
  get '/checkout', to: 'checkout#index', as: 'checkout_index'

end
