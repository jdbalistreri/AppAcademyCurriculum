class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?

  def current_user
    return nil if session[:token].nil?
    @current_user ||= User.find_by_session_token(session[:token])
  end

  def signed_in?
    !!current_user
  end

  def login!(user)
    @current_user = user
    user.reset_session_token!
    session[:token] = user.session_token
  end

  def logout!
    current_user.try(:reset_session_token!)
    session[:token] = nil
  end

  def login_filter
    flash[:notice] = "You don't need that page. You are already logged in"
    redirect_to cats_url if signed_in?
  end

  def require_login
    flash[:notice] = "You must be logged in to do that"
    redirect_to cats_url unless signed_in?
  end

  def require_cat_ownership
    flash[:notice] = "You don't own that cat"
    redirect_to cats_url unless current_user.id == params[:id].to_i
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
