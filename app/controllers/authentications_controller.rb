class AuthenticationsController < ActionController::Base
  def show
    @authentication = Authentication.find(params[:id])
  end
  
  def index
    @authentications = Authentication.all
  end
  
  def destroy
    auth = Authentication.find(params[:id])
    auth.destroy
    
    redirect_to root_url, :notice => "Signed out!"
  end
end
