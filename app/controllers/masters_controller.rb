class MastersController < ApplicationController
  def show
    @master = Master.find(params[:id])
  end
  
  def index
    @masters = Master.all
  end
  
  def edit
    @master = Master.find(params[:id])
  end
  
  def update
    @master = Master.find(params[:id])
    if @master.update_attributes(params[:master])
      flash[:success] = "Profile updated."
      redirect_to @master
    else
      render 'edit'
    end
  end
end
