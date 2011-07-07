class IdentitiesController < ApplicationController
  def show
    @identity = Identity.find(params[:id])
  end
  
  def index
    @identities = Identity.all
  end
end
