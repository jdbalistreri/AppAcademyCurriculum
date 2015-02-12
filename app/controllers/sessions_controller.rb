class SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(
              params[:user][:email],
              params[:user][:password]
              )

    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      @user = User.new(user_params)
      @user.errors[:base] = "Could not find your username/password"
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

end
