Rails.application.routes.draw do
  devise_for :users
  root to: 'katas#index'

  get '/users' => 'users#index', as: :users
  patch '/become_admin/:id' => 'users#become_admin', as: :become_admin
  patch '/revoke_admin/:id' => 'users#revoke_admin', as: :revoke_admin
  delete '/user/:id/delete' => 'users#destroy', as: :delete_user

  resources :katas

  post '/belt/create/:kata_id' => 'belts#create', as: :belt
  delete '/belt/:id/delete' => 'belts#destroy', as: :delete_belt
end
