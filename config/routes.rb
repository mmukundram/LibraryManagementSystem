Rails.application.routes.draw do
  get             'calendars/index'

  get             'home',             to: 'home#index'
  get             'home/history',     to: 'home#history'

  get             '/login',           to: 'sessions#new'
  post            '/login',           to: 'sessions#create'
  delete          '/logout',          to: 'sessions#destroy'

  resources       :bookings
  resources       :users
  resources       :admins

  resources       :rooms
  get             '/search/rooms',     to: 'rooms#search'
  post            '/privilege',        to: 'users#togglePrivilege'

  root 'sessions#new'
end
