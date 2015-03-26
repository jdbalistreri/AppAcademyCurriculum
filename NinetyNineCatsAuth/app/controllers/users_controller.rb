class UsersController < ApplicationController
  before_action :require_no_user!, only: [:new, :create]
  before_action :require_user!, only: :show

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login_user!(@user)
      flash[:notice] = "Thanks for signing up #{@user.user_name}"
      redirect_to cats_url
    else
      render :new
    end
  end

  def show

    render :show
  end
end
