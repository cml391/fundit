class VolunteersController < ApplicationController
  before_filter :require_volunteer, :only => [:edit, :update]
  before_filter :find_volunteer, :except => [:index, :new, :create]
  before_filter :require_ownership, :only => [:edit, :update]

	# GET /volunteers
  # GET /volunteers.json
  def index
    @volunteers = Volunteer.order(:name).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @name }
    end
  end


  # GET /volunteers/1
  # GET /volunteers/1.json
  def show
    @volunteer = Volunteer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @volunteer }
    end
  end

  # GET /volunteers/new
  # GET /volunteers/new.json
  def new
    @volunteer = Volunteer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @volunteer }
    end
  end

  # GET /volunteers/1/edit
  def edit
    @volunteer = Volunteer.find(params[:id])
  end

  # POST /volunteers
  # POST /volunteers.json
  def create
    @volunteer = Volunteer.new(params[:volunteer])

    respond_to do |format|
      if @volunteer.save
        session[:user_id] = @volunteer.id
        session[:user_type] = 'Volunteer'
        format.html { redirect_after_login }
        format.json { render json: @volunteer, status: :created, location: @volunteer }
      else
        format.html { render action: "new" }
        format.json { render json: @volunteer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /volunteers/1
  # PUT /volunteers/1.json
  def update
    @volunteer = Volunteer.find(params[:id])

    respond_to do |format|
      if @volunteer.update_attributes(params[:volunteer])
        format.html { redirect_to @volunteer, notice: 'Volunteer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @volunteer.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def find_volunteer
    @volunteer = Volunteer.find(params[:id])
  end

  def require_ownership
    unless @volunteer == current_user
      redirect_to root_url, :alert => "You don't own that volunteer."
    end
  end
end
