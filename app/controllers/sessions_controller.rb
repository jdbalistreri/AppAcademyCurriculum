class SessionsController < ApplicationController
  before_action :login_filter, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params['user_name'], user_params['password'])
    if @user
      login!(@user)

      flash[:notice] = "Thanks for logging in #{current_user.user_name}"
      redirect_to cats_url
    else
      @user = User.create(user_params)
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

end
