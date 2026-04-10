Rails.application.routes.draw do
  root to: "visitors#index"

  devise_for :users

  resources :events
  resources :payments
  resource :shopping_cart
end
