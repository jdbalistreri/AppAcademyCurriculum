Rails.application.routes.draw do

  root "root#root"

  resources(:posts,
            only: [:show, :create, :index, :destroy]
            # default: :json
  )

end
