class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Thanks for signing up #{@user.user_name}"
      redirect_to cats_url
    else
      render :new
    end
  end
end
