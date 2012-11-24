class ParticipationsController < ApplicationController
  before_filter :require_user, :except => [:show, :donate_form, :donate]
  before_filter :require_volunteer, :except => [:show, :donate_form, :donate]
  before_filter :find_participation, :except => [:new, :create]
  before_filter :require_ownership, :only => [:edit, :update]

  # GET /volunteers/1/participations/1
  # GET /volunteers/1/participations/1.json
  def show
    @participation = Participation.find(params[:id])
    @offline_perc = @participation.donation_sum
    @online_perc = @participation.donation_percent
    @donation = Donation.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @participation }
    end
  end

  # GET /volunteers/1/participations/new
  # GET /volunteers/1/participations/new.json
  def new
    # if the volunteer id is 0, it means the user tried to participate while
    # logged out, got redirected to login, and then redirected back. Redirect
    # them to the right url.
    puts params[:volunteer_id]
    if params[:volunteer_id] == '0'
      return redirect_to new_volunteer_participation_url(current_user, request.query_parameters)
    end

    @participation = Participation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @participation }
    end
  end

  # GET /volunteers/1/participations/1/edit
  def edit
    @participation = Participation.find(params[:id])
  end

  # POST /volunteers/1/participations
  # POST /volunteers/1/participations.json
  def create
    @participation = Participation.new(params[:participation])
    @participation.volunteer = current_user
    @participation.event = Event.find(params[:event_id])

    respond_to do |format|
      if @participation.save
        format.html { redirect_to volunteer_participation_url(current_user, @participation), notice: 'Participation was successfully created.' }
        format.json { render json: @participation, status: :created, location: @participation }
      else
        format.html { render action: "new" }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /volunteers/1/participations/1
  # PUT /volunteers/1/participations/1.json
  def update
    @participation = Participation.find(params[:id])

    respond_to do |format|
      if @participation.update_attributes(params[:participation])
        format.html { redirect_to volunteer_participation_url(current_user, @participation), notice: 'Participation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /volunteers/1/participations/1
  # GET /volunteers/1/participations/1.json
  def donate_form
    @donation = Donation.new
  end

  # POST /volunteers/1/participations/1
  # POST /volunteers/1/participations/1.json
  def donate
    @donation = Donation.new(params[:donation])
    @donation.participation = @participation

    respond_to do |format|
      if @donation.save
        format.html { redirect_to volunteer_participation_url(@participation.volunteer, @participation), notice: 'Donation was successful. Thank you for your contribution.' }
        format.json { render json: @donation, status: :created, location: @donation }
      else
        format.html { render action: "donate_form" }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def find_participation
    @participation = Participation.find(params[:id])
  end

  def require_ownership
    unless @participation.volunteer == current_user
      redirect_to root_url, :alert => "You don't own that participation."
    end
  end
end
