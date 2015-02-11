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
    redirect_to cats_url if signed_in?
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
