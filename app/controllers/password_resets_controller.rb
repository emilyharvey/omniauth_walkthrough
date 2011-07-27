class PasswordResetsController < ApplicationController
  def new
  end

  def create  
	  identity = Identity.find_by_email(params[:email])  
	  #identity.send_password_reset if identity  
	  if (identity)
	  	redirect_to root_url, :notice => "Go To: http://omniauth-tutorial.heroku.com/password_resets/" + identity.password_reset_token + "/edit"
	  else
		  redirect_to root_url, :notice => "This email address is not registered yet"  
		end
	end  

	def edit  
	  @identity = Identity.find_by_password_reset_token!(params[:id])
	end  

	def update  
	  @identity = Identity.find_by_password_reset_token!(params[:id])
	  if @identity.password_reset_sent_at < 2.hours.ago  
	    redirect_to new_password_reset_path, :alert => "Password reset has expired."  
	  elsif @identity.update_attributes(params[:identity])  
	    redirect_to root_url, :notice => "Password has been reset."  
	  else  
	    render :edit  
	  end  
	end  
end
