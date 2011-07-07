class ApplicationController < ActionController::Base
  protect_from_forgery
  # Basic user session handling
  helper_method :current_user, :clear_authentications

  private
  def current_user
    @current_user ||= Master.find(cookies.signed[:master_id].to_i) if cookies.signed[:master_id]
  end
  
  def clear_authentications
    #authentications = current_user.authentications.all
    # Tighten the datatype to work in Heroku
    authentications = Authentication.find :all, :conditions => ["master_id = ?", current_user.id.to_s]
    authentications.each do |auth|
      auth.destroy
    end
  end
end
