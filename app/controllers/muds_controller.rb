class MudsController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :index]
  
  def index
    @muds = Mud.all
  end

  def show
    @mud = Mud.find(params[:id])
  end

  def new
    @mud = Mud.new
  end
  
  def create
    @mud = Mud.new(mud_params)
    
    if @mud.save
        redirect_to @mud, notice: "MUD request submitted successfully!"
      else
        flash.now[:alert] = "Unable to submit new MUD request. Please try again."
        render :new
    end
  end

  def edit
    @mud = Mud.find(params[:id])
  end
  
  def update
    @mud = Mud.find(params[:id])
    @mud.assign_attributes(mud_params)
    
    if @mud.save
      flash[:notice] = "MUD was updated successfully."
      redirect_to @mud
    else
      flash.now[:alert] = "There was an error updating the MUD. Please try again."
    end    
  end
  
  def destroy
    @mud = Mud.find(params[:id])
    
    if @mud.destroy
      flash[:notice] = "Mud was successfully removed."
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error removing this MUD. Please try again."
    end    
  end
  
  
  private
  
  def mud_params
    params.require(:mud).permit(:name, :url, :verified)
  end
  
end
