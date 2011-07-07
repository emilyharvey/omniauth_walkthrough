class AuthenticationsController < ActionController::Base
  def destroy
    auth = Authentication.find(params[:id])
    auth.destroy
    
    redirect_to root_url, :notice => "Signed out!"
  end
end
