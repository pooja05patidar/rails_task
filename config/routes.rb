Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }

    resources :restaurants
    resources :owners
    resources :menus
    resources :orders
    resources :order_items
    resources :reviews
    resources :deliveries

resources :customers
end
