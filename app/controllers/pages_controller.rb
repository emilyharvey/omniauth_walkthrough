class PagesController < ApplicationController
  def home
    if current_user
      @authentications = current_user.authentications.all
      @count = @authentications.count
    end
  end

  def error
  end

end
