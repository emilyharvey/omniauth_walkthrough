class PagesController < ApplicationController
  def home
    if current_user
      @authentications = current_user.authentications.all
    end
  end

  def error
  end

end
