Rails.application.routes.draw do
  resources :rooms
  resources :bookings
  resources :users

  root 'login#index'
end
