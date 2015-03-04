Rails.application.routes.draw do

  resources(:posts,
            only: [:show, :create, :index, :update],
            default: :json
  )

end
