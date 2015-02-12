Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]

  resources :bands do
    resources :albums, only: :new
  end

  resources :albums, except: [:new, :index] do
    resources :tracks, only: :new
  end

  resources :tracks, except: [:new, :index] do
    resources :notes, only: :create
  end

  resources :notes, only: :destroy
end
