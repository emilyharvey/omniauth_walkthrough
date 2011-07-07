class ApplicationController < ActionController::Base
  protect_from_forgery
  # Basic user session handling
  helper_method :current_user

  private
  def current_user
    @current_user ||= User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
  end
end
