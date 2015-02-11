class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  private
    def require_no_user!
      if logged_in?
        flash[:notice] = "You don't need that page. You are already logged in"
        redirect_to cats_url
      end
    end

    def require_user!
      unless logged_in?
        flash[:notice] = "You must be logged in to do that"
        redirect_to cats_url
      end
    end

    def current_user
      return nil unless session[:token]
      @current_user ||= User.find_by_session_token(session[:token])
    end

    def logged_in?
      !!current_user
    end

    def login_user!(user)
      session[:token] = user.reset_session_token!
    end

    def logout_user!
      current_user.try(:reset_session_token!)
      session[:token] = nil
    end

    def require_cat_ownership
      @cat = Cat.find(params[:cat][:id])
      unless @cat.user_id == current_user.id
        flash[:notice] = "You don't own that cat"
        redirect_to cats_url
      end
    end

    def user_params
      params.require(:user).permit(:user_name, :password)
    end

end
