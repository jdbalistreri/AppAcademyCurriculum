class SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(
              params[:user][:email],
              params[:user][:password]
              )

    if @user
      login!(@user)
      fail

    else
      @user = User.new(user_params)
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def destroy

  end

end
