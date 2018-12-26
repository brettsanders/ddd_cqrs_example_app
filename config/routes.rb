Rails.application.routes.draw do
  root 'dashboard#show'

  resources :orders, only: [:index, :show, :new, :create] do
    collection do
      post :expire
    end
    member do
      post :add_item
      post :remove_item
    end
  end

  resources :wallets, only: [:index, :show, :new, :create] do
    member do
      post :add_money
    end
  end

  mount RailsEventStore::Browser => '/res'
end
