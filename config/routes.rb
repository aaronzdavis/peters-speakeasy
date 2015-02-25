Rails.application.routes.draw do
  root 'memberships#new'
  resources :memberships, only: [:new, :create, :show]
end