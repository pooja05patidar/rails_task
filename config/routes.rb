# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  get 'admin/index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  # get '/users/auth/:provider/callback', to: 'users/omniauth_callbacks#omniauth_callbacks'
  # get '/users/auth/failure', to: 'users/omniauth_callbacks#failure'

  devise_scope :user do
    post 'apply_for_owner', to: 'users/registrations#apply_for_owner'
    get 'users/:id', to: 'users/sessions#show'
    get 'users', to: 'users/sessions#index'
    post 'users/id', to: 'users/sessions#respond_to_on_destroy'
    # get '/users/auth/:provider/callback', to: 'users/omniauth_callbacks#omniauth_callbacks'
    # get '/users/auth/failure', to: 'users/omniauth_callbacks#failure'
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
  resources :cart_items
end
