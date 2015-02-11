class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(params.require(:user).permit(:user_name, :password))

    if @user.save
      flash[:notice] = "Thanks for signing up #{@user.user_name}"
      redirect_to cats_url
    else
      render :new
    end
  end
end
