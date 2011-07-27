class IdentityMailer < ActionMailer::Base
  default :from => "from@example.com"

  def password_reset(identity)  
    @identity = identity
    mail :to => identity.email, :subject => "Password Reset"  
  end 
end
