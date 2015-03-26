Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests, only: [:new, :create, :destroy]
  resource :user, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]

  post '/cat_rental_requests/approve' => 'cat_rental_requests#approve'
  post '/cat_rental_requests/deny' => 'cat_rental_requests#deny'
end
