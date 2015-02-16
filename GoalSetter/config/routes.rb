Rails.application.routes.draw do
  resources :users, only: [:new, :create, :index, :show]

  resources :goals

  resources :comments, only: [:create]

  resource :session, only: [:new, :create, :destroy]
end
