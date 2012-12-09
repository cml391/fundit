class ParticipationsController < ApplicationController
  before_filter :require_user, :except => [:show, :donate_form, :donate]
  before_filter :require_volunteer, :except => [:show, :donate_form, :donate]
  before_filter :find_participation, :except => [:new, :create]
  before_filter :require_ownership, :only => [:edit, :update, :thank_form,
                                              :thank, :offline_donate,
                                              :offline_donate_form]
  before_filter :find_donation, :only => [:thank, :thank_form]

  # GET /volunteers/1/participations/1
  # GET /volunteers/1/participations/1.json
  def show
    @participation = Participation.find(params[:id])
    @volunteer = @participation.volunteer

    @offline_perc = @participation.offline_donation_percent
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
        format.html { render action: "show" }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  def offline_donate_form
  	@offline_donation = OfflineDonation.new
  end

  # POST /volunteers/1/participations/1
  # POST /volunteers/1/participations/1.json
  def offline_donate
    @offline_donation = OfflineDonation.new(params[:offline_donation])
    @offline_donation.participation = @participation

    respond_to do |format|
      if @offline_donation.save
        format.html { redirect_to volunteer_participation_url(@participation.volunteer, @participation), notice: 'Offline donation was logged successfully' }
        format.json { render json: @offline_donation, status: :created, location: @donation }
      else
        format.html { render action: "offline_donate_form" }
        format.json { render json: @offline_donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /volunteers/1/participations/1/thank?donation_id=1
  def thank_form
  end

  # POST /volunteers/1/participations/1/thank
  def thank
    Pony.mail :to => "\"#{@donation.name}\" <#{@donation.email}>",
              :from => "\"#{@volunteer.name}\" <#{@volunteer.email}>",
              :subject => "Thank you for supporting me in #{@participation.event.name}",
              :body => params[:message]

    @donation.thank_you_sent = true
    @donation.save!
    redirect_to volunteer_participation_url(@participation.volunteer, @participation)
  end

  private

  def find_participation
    @participation = Participation.find(params[:id])
    @volunteer = @participation.volunteer
    @event = @participation.event
  end

  def find_donation
    if params[:donation_type] == 'offline'
      @donation = OfflineDonation.find_by_id(params[:donation_id])
    else
      @donation = Donation.find_by_id(params[:donation_id])
    end
  end

  def require_ownership
    unless @participation.volunteer == current_user
      redirect_to root_url, :alert => "You don't own that participation."
    end
  end
end
