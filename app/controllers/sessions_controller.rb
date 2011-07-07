class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    provider = auth["provider"]
    uid = auth["uid"]
    if cookies.signed[:user_id] == nil
      # If no user is currently signed in:
      # See if the user has signed in before. 
      #  If not, create the user.
      new_user = User.find_by_provider_and_uid(provider, uid) || User.create_with_omniauth(auth)
      cookies.signed[:user_id] = new_user.id
      
      # Clear all historical connections since they were not 
      #  closed properly on last close.
      authentications = current_user.authentications.all
      authentications.each do |auth|
        auth.destroy
      end
end
 
authentication = 
    Authentication.find_by_provider_and_uid(provider, uid)
    if authentication == nil
      # Only create a new authentication for the user if the 
      #  user has not signed in previously.
      current_user.authentications.create!(:provider => provider, :uid => uid)
    end
    
    redirect_to root_url, :notice => "Signed in!"
  end                                                           
  
  def destroy
    authentications = current_user.authentications.all
    authentications.each do |auth|
      auth.destroy
    end
    
    cookies.delete :user_id
    redirect_to root_url, :notice => "Signed out!"
  end
end
