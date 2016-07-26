class PagesController < ApplicationController
  before_action :authenticate_user!, :except => [:show]
  
  
  def new
    @wiki = Wiki.find(params[:wiki_id])
    @page = Page.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @page = @wiki.pages.build(page_params)
    
     if @page.save
       flash[:notice] = "Page was saved successfully."
       redirect_to [@wiki, @page]
     else
       flash.now[:alert] = "There was an error saving the new page. Please try again."
       render :new
     end
  end

  def show
    @page = Page.find(params[:id])
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    @page.assign_attributes(page_params)
    
    if @page.save
      flash[:notice] = "Page was updated successfully."
      redirect_to [@page.wiki, @page]
    else
      flash.now[:alert] = "There was an error saving the page. Please try again."
      render :edit
    end
  end

  def destroy
    @page = Page.find(params[:id])
    
    if @page.destroy
      flash[:notice] = "\"#{@page.title}\" was deleted successfully."
      redirect_to @page.wiki
    else
      flash.now[:alert] = "There was an error deleting the page."
      render :show
    end 
  end
  
  
  private
  
  def page_params
    params.require(:page).permit(:title, :body)
  end
end
