class Identity < OmniAuth::Identity::Models::ActiveRecord
	validates_presence_of :username, :email
	validates_uniqueness_of :username
	auth_key :username
end
