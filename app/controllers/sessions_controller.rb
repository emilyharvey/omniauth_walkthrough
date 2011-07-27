class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    provider = auth["provider"].to_s
    uid = auth["uid"].to_s
    
    user = User.find_by_provider_and_uid(provider,uid)
    if cookies.signed[:master_id] == nil
      # If a user has not been signed in at all
      if user == nil
        # If the current user has not been signed in
        master = Master.create_with_omniauth(auth)
        user = User.create_with_omniauth(auth, master.id)
        cookies.signed[:master_id] = master.id
      else
        cookies.signed[:master_id] = user.master
      end
      
      clear_authentications
    else
      # If no user has been signed in yet, create them or update
      #  the user to indicate with a main/master account id
      if user == nil
        User.create_with_omniauth(auth, cookies.signed[:master_id])
      else
        user.update_attributes(:master => cookies.signed[:master_id])
      end
    end
    
    auth = Authentication.find_by_provider_and_uid(provider, uid)
    if auth == nil
      current_user.authentications.create!(:provider => provider, :uid => uid)
    end
    
    redirect_to root_url, :notice => "Signed in!"
  end
  
  def destroy
    clear_authentications
    
    cookies.delete :master_id
    redirect_to root_url, :notice => "Signed out!"
  end
end
