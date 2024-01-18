Rails.application.routes.draw do
  get 'admin/index'
    devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }
    devise_scope :user do
      post 'apply_for_owner', to: 'users/registrations#apply_for_owner'
    end
    # namespace :admin do
    #   resources :owners, only: [:index]
    # end
  post 'admin/approve_owner/:user_id', to: 'admin#approve_owner'#, as: :approve_owner

    resources :restaurants
    resources :owners
    resources :menus
    resources :orders
    # resources :order_items
    resources :reviews
    resources :deliveries
    get '/filter_menu', to: 'menus#filter_menu'
    resources :customers
    resource :cart, only: [:show] do
      post 'add_to_cart/:menu_id', action: :add_to_cart, on: :member
      delete 'remove_from_cart/:id', action: :remove_from_cart, on: :member
    end
    # resources :cart_items
end
