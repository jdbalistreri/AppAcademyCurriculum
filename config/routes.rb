Rails.application.routes.draw do
  resources :cats do
    resources :cat_rental_requests
  end
end
