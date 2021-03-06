Rails.application.routes.draw do
  get 'welcome/index'
  resources :bookings
  resources :payment_methods
  resources :transactions
  resources :flights, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
