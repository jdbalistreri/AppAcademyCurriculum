Rails.application.routes.draw do

  resources :subs, except: :destroy
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]

end
