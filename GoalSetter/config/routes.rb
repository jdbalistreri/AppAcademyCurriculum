Rails.application.routes.draw do
  resources :users, only: [:new, :create, :index, :show]

  resources :goals

  resource :session, only: [:new, :create, :destroy]
end
