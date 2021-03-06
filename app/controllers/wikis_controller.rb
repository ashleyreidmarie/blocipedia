class WikisController < ApplicationController
  before_action :authenticate_user!, :except => [:show]

  def new
    authorize Wiki
    @wiki = Wiki.new
  end

  def create
    authorize Wiki
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    
    if @wiki.save
      redirect_to @wiki, notice: "Wiki was saved successfully"
    else
      flash.now[:alert] = "Unable to create new wiki. Please try again."
      render :new
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    
    @wiki.assign_attributes(wiki_params)
    
    if @wiki.save
      flash[:notice] = "Wiki was updated successfully."
      redirect_to @wiki
    else
      flash[:alert] = "There was an error updating wiki. Please try again."
      redirect_to :back
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    
    if @wiki.destroy
      flash[:notice] = "Wiki was successfully deleted."
      redirect_to @wiki.mud
    else
      flash.now[:alert] = "There was an error deleting this wiki. Please try again."
    end
  end
  
  
  private
  
  def wiki_params
    params.require(:wiki).permit(WikiPolicy.new(current_user, @wiki).permitted_params_for(params["action"]))
  end
  
end
