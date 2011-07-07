class User < ActiveRecord::Base
  has_many :authentications
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.authblob = auth.to_yaml
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
      user.email = auth["user_info"]["email"]
    end
  end
end
