class WikisController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :index]
  
  def index
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    
    if @wiki.save
      redirect_to @wiki, notice: "Wiki was saved successfully"
    else
      flash.now[:alert] = "Unable to create new wiki. Please try again."
      render :new
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)
    
    if @wiki.save
      flash[:notice] = "Wiki was updated successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error updating wiki. Please try again."
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    
    if @wiki.destroy
      flash[:notice] = "Wiki was successfully deleted."
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error deleting this wiki. Please try again."
    end
  end
  
  
  private
  
  def wiki_params
    params.require(:wiki).permit(:name, :description)
  end
  
end
