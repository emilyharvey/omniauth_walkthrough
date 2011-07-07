class User < ActiveRecord::Base
  def self.create_with_omniauth(auth, master_id)
    create! do |user|
      user.authdom = auth.to_yaml
      user.provider = auth["provider"].to_s
      user.uid = auth["uid"].to_s
      user.name = auth["user_info"]["name"].to_s
      user.email = auth["user_info"]["email"].to_s
      user.master = master_id
    end
  end
end
