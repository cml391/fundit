class OrganizationsController < ApplicationController
  before_filter :require_organization, :only => [:edit, :update]
  before_filter :find_organization, :except => [:index, :new, :create, :new_stripe]
  before_filter :require_ownership, :only => [:edit, :update]

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = Organization.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @organizations }
    end
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
    @followalready = Organization.follow_already(current_user.id, @organization.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @organization }
    end
  end

  # GET /organizations/new_stripe
  # prompts the user to connect to Stripe
  def new
  end

  # GET /organizations/new
  # GET /organizations/new.json
  def new
    @organization = Organization.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @organization }
    end
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(params[:organization])

    respond_to do |format|
      if @organization.save
        session[:user_id] = @organization.id
        session[:user_type] = 'Organization'
        format.html { redirect_after_login }
        format.json { render json: @organization, status: :created, location: @organization }
      else
        format.html { render action: "new" }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /organizations/1
  # PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update_attributes(params[:organization])
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /organizations/1/follow
  def follow
    if Organization.follow_already(current_user.id, @organization.id)
      format.html { redirect_to @organization, notice: 'You already follow the organization.' }
    else
      @follow = Follow.new(params[:follow])

      @follow.volunteer_id = current_user.id
      @follow.organization_id = params[:id]

      respond_to do |format|
        if @follow.save
          format.html { redirect_to @organization, notice: 'Follow was successfully created.' }
          format.json { render json: @organization, status: :created, location: @organization }
        end
      end
    end
  end

  # DELETE /organizations/1/unfollow
  def unfollow
    @follow = Follow.where("volunteer_id=?", current_user.id).where("organization_id=?", params[:id]).first()
    if @follow
      @follow.destroy
      respond_to do |format|
        format.html { redirect_to @organization, notice: 'You have successfully unfollowed the organization.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to @organization, notice: 'You were not following the organization.' }
        format.json { head :no_content }
      end
    end
  end

  private

  def find_organization
    @organization = Organization.find(params[:id])
  end

  def require_ownership
    unless @organization == current_user
      redirect_to root_url, :alert => "You don't own that organization."
    end
  end

end
