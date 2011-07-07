class User < ActiveRecord::Base
  def self.create_with_omniauth(auth, master_id)
    create! do |user|
      user.authdom = auth.to_yaml
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
      user.email = auth["user_info"]["email"]
      user.master = master_id
    end
  end
end
