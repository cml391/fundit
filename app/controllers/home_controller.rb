class HomeController < ApplicationController
  def index
  	@volunteer = Volunteer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @volunteer }
    end
  end
  
end
