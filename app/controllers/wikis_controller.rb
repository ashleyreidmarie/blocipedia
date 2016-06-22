class WikisController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :index]
  
  def index
    @wikis = Wiki.all
  end

  def new
  end

  def create
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
