class SessionsController < ApplicationController

  def create
    @user = "s"
  end

  def new
    @user = User.new
    render :new
  end

  def destroy

  end

end
