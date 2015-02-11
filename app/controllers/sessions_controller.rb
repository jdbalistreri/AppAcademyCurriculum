class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params['user_name'], user_params['password'])
    if @user
      @user.reset_session_token!
      session[:token] = @user.session_token

      flash[:notice] = "Thanks for logging in #{@user.user_name}"
      redirect_to cats_url
    else
      @user = User.create(user_params)
      render :new
    end
  end

end
