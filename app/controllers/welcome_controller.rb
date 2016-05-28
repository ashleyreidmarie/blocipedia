class WelcomeController < ApplicationController
  def index
  end

private

  def resource
    User.new
  end
  
  def resource_name
    'user'
  end
end
