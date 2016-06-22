class PagesController < ApplicationController
  def index
    @wiki = Wiki.find(params[:wiki_id])
    @pages = @wiki.pages
  end
  
  def new
  end

  def create
  end

  def show
    @page = Page.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
