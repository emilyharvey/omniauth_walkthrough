class PagesController < ApplicationController
  def home
    if current_user
      #@authentications = current_user.authentications.all
      # Tighten the datatype to work in Heroku
      @authentications = Authentication.find :all, :conditions => ["master_id = ?", current_user.id.to_s]
      @count = @authentications.count
    end
  end

  def error
  end

end
