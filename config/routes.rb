Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'memberships#new'
  get 'guestlist' => 'memberships#guestlist'
  resources :memberships, only: [:new, :create, :show]
end