class ApplicationController < ActionController::Base
  protect_from_forgery
  # Basic user session handling
  helper_method :current_user, :clear_authentications

  private
  def current_user
    @current_user ||= Master.find(cookies.signed[:master_id]) if cookies.signed[:master_id]
  end
  
  def clear_authentications
    authentications = current_user.authentications.all
    authentications.each do |auth|
      auth.destroy
    end
  end
end
