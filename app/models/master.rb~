class Master < ActiveRecord::Base
  has_many :authentications
  
  def self.create_with_omniauth(auth)
    create! do |master|
      master.name = auth["user_info"]["name"]
      master.bgcolor = "#FBF984"
    end
  end
end
