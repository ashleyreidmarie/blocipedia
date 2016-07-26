class MudsController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :index]
  
  def index
    @muds = Mud.approved
  end

  def show
    @mud = Mud.find(params[:id])
    
   redirect_to muds_path, alert: "#{@mud.name} is still awaiting approval. Please try again later" unless @mud.approved == true
  end

  def new
    @mud = Mud.new
  end
  
  def create
    @mud = Mud.new(mud_params)
    
    if @mud.save
        redirect_to muds_path, notice: "MUD request submitted successfully!"
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
      flash[:notice] = "#{@mud.name} was updated successfully."
      redirect_to @mud
    else
      flash.now[:alert] = "There was an error updating the MUD. Please try again."
    end    
  end
  
  def destroy
    @mud = Mud.find(params[:id])
    
    if @mud.wikis.count > 0
      flash[:alert] = "You cannot delete a mud with wikis still assigned."
    elsif @mud.destroy
      flash[:notice] = "#{@mud.name} was successfully deleted."
    else
      flash[:alert] = "There was an error removing this MUD. Please try again."
    end    
    redirect_to dashboard_muds_path
  end
  
  def dashboard
    @muds = Mud.all
  end
  
  def approval
      @mud = Mud.find(params[:id])
      # authorize(@mud)
      if @mud.update(approved: true)
        flash[:notice] = "#{@mud.name} was successfully approved!"
        redirect_to dashboard_muds_path
      else
        flash.now[:alert] = "There was an error approving this MUD. Please try again."
      end
  end
  
  
  private
  
  def mud_params
    params.require(:mud).permit(:name, :url)
  end
  
end
