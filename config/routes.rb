Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :items, only: [:index, :show]
  resources :orders
  post "/login", to: "sessions#create"
  post "/register", to: "registration#create"
  post "add_or_update_cart", to: "order_details#create"
end
