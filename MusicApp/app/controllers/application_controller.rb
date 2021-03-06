class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user

  def login!(user)
    session[:token] = user.reset_session_token!
  end

  def logout!
    current_user.reset_session_token!
    session[:token] = nil
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:token])
  end

  def require_user
    unless logged_in?
      redirect_to new_session_url
      flash[:notice] = "You must be logged in to access that page."
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
