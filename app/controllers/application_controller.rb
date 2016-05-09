class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #allow methods to be used in the views.
  helper_method :current_user, :logged_in?, :display_name
  
  def current_user
    @current_user ||= Chef.find(session[:chef_id]) if session[:chef_id]
  end
  
  def logged_in?
    !!current_user
  end
  
  def display_name
    @current_user.name
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You need to log in first."
      redirect_to login_path
    end
  end
end
