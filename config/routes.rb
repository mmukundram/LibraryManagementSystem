Rails.application.routes.draw do
  get             'home',             to: 'home#index'

  get             '/login',           to: 'sessions#new'
  post            '/login',           to: 'sessions#create'
  delete          '/logout',          to: 'sessions#destroy'

  resources       :rooms
  resources       :bookings
  resources       :users
  resources       :admins

  root 'sessions#new'
end
