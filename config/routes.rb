Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :items, only: [:index, :show]
  resources :orders, only: [:update]
  resources :offers, only: [:index]
  get "current_order", to: "orders#current_order"
  post "/login", to: "sessions#create"
  post "/register", to: "registration#create"
  post "add_or_update_cart", to: "order_details#create"
end
