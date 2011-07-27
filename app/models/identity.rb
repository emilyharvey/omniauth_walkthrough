class Identity < OmniAuth::Identity::Models::ActiveRecord
	validates_presence_of :username, :email
	validates_uniqueness_of :username, :email
	auth_key :username
	before_create { generate_token(:auth_token) }

	def generate_token(column)
	  begin
	    self[column] = SecureRandom.urlsafe_base64
	  end while Identity.exists?(column => self[column])
	end

	def send_password_reset  
	  generate_token(:password_reset_token)  
	  self.password_reset_sent_at = Time.zone.now  
	  save!  
	  IdentityMailer.password_reset(self).deliver  
	end
end
