Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }

    resources :restaurants
    resources :owners
    resources :menus
    # resources :orders
    # resources :order_items
    resources :reviews
    resources :deliveries
    get '/filter_menu', to: 'menus#filter_menu'
    resources :customers
    resources :orders do
      collection do
        post :add_to_cart
      end
    end
end
