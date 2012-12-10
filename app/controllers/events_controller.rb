class EventsController < ApplicationController
  before_filter :require_organization, :except => [:show, :index]
  before_filter :find_event, :except => [:new, :create, :index]
  before_filter :require_ownership, :only => [:edit, :update]

	# GET /events
  # GET /events.json
  def index
    @events = Event.where("date >= ?", Date.today).order(:date).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end


  # GET /organizations/1/events/1
  # GET /organizations/1/events/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /organizations/1/events/new
  # GET /organizations/1/events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /organizations/1/events/1/edit
  def edit
  end

  # POST /organizations/1/events
  # POST /organizations/1/events.json
  def create
    @event = Event.new(params[:event])
    @event.organization = current_user

    @event.organization.follows.each do | follow |    
      Pony.mail :to => "\"#{follow.volunteer.name}\" <#{follow.volunteer.email}>",
            :from => "FundIt <fundit@fundit.org>",
            :subject => "#{@event.organization.name} just created #{@event.name}.",
            :body => "Check it out at http://fundit.herokuapp.com/organizations/#{@event.organization.id}/events/#{@event.id}."
    end

    respond_to do |format|
      if @event.save
        format.html { redirect_to organization_event_url(@event.organization, @event), notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /organizations/1/events/1
  # PUT /organizations/1/events/1.json
  def update
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to organization_event_url(@event.organization, @event), notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def find_event
    @event = Event.find(params[:id])
  end

  def require_ownership
    unless @event.organization == current_user
      redirect_to root_url, :alert => "You don't own that event."
    end
  end
end
