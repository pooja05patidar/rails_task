# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  get 'admin/index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    post 'apply_for_owner', to: 'users/registrations#apply_for_owner'
    get 'users/:id', to: 'users/sessions#show'
  end

  post 'admin/approve_owner/:user_id', to: 'admin#approve_owner'
  resources :restaurants do
    member do
      put 'reactivate'
    end
  end

  resources :menu_items
  resources :orders
  resources :reviews

  get '/filter_menu', to: 'menu_items#filter_menu'

  resource :cart, only: [:show] do
    post 'add_to_cart/:menu_id', action: :add_to_cart, on: :member
    delete 'remove_from_cart/:id', action: :remove_from_cart, on: :member
  end
end
