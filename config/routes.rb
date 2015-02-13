Rails.application.routes.draw do

  resources :subs, except: :destroy do
    resources :posts, only: [:new]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :posts, except: [:index, :destroy, :new]
end
