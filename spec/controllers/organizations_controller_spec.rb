require 'spec_helper'

describe OrganizationsController do
  describe "GET index" do
    it "assigns all organizations as @organizations, ordered by name" do
      Organization.all.each &:destroy
      o1 = create :organization, :name => 'b'
      o2 = create :organization, :name => 'a'
      o3 = create :organization, :name => 'c'

      get :index
      assigns(:organizations).should eq([o2, o1, o3])
    end
  end

  describe "GET show" do
    before :each do
      Event.all.each &:destroy
      @org = create :organization
      @evt1 = create :event, :date => 2.days.ago, :organization => @org
      @evt2 = create :event, :date => 4.days.from_now, :organization => @org
      @evt3 = create :event, :date => 2.days.from_now, :organization => @org
    end

    it "assigns future events as @futureevents" do
      get :show, :id => @org.id
      assigns(:futureevents).should =~ [@evt2, @evt3]
    end

    it "assigns past events as @pastevents" do
      get :show, :id => @org.id
      assigns(:pastevents).should =~ [@evt1]
    end

    it "sets @followalready to false if the user isn't following the organization" do
      get :show, :id => @org.id
      assigns(:followalready).should be_false
    end

    it "sets @followalready to true if the user is following the organization" do
      user = log_in_as :volunteer
      create :follow, :volunteer => user, :organization => @org
      get :show, :id => @org.id
      assigns(:followalready).should be_true
    end
  end

  describe "GET new_stripe" do
    it "renders the new_stripe template" do
      get :new_stripe
      response.should render_template('new_stripe')
    end
  end

  describe "GET new" do
    it "assigns a new organization as @organization" do
      get :new
      assigns(:organization).should be_a_new(Organization)
    end
  end

  describe "GET edit" do
    before :each do
      @org = log_in_as :organization
    end

    it "assigns the requested organization as @organization" do
      get :edit, :id => @org.id
      assigns(:organization).should eq(@org)
    end

    it "requires the user to own the organization" do
      log_in_as :organization
      get :edit, :id => @org.id
      response.should redirect_to(root_url)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Organization" do
        expect {
          post :create, :organization => attributes_for(:organization)
        }.to change(Organization, :count).by(1)
      end

      it "assigns a newly created organization as @organization" do
        post :create, :organization => attributes_for(:organization)
        assigns(:organization).should be_a(Organization)
        assigns(:organization).should be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved organization as @organization" do
        # Trigger the behavior that occurs when invalid params are submitted
        Organization.any_instance.stub(:save).and_return(false)
        post :create, :organization => {}
        assigns(:organization).should be_a_new(Organization)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Organization.any_instance.stub(:save).and_return(false)
        post :create, :organization => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before :each do
      @org = log_in_as :organization
    end

    describe "with valid params" do
      it "updates the requested organization" do
        # Assuming there are no other organizations in the database, this
        # specifies that the Organization created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Organization.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => @org.to_param, :organization => {'these' => 'params'}
      end

      it "assigns the requested organization as @organization" do
        put :update, :id => @org.to_param, :organization => attributes_for(:organization)
        assigns(:organization).should eq(@org)
      end

      it "redirects to the organization" do
        put :update, :id => @org.to_param, :organization => attributes_for(:organization)
        response.should redirect_to(@org)
      end

      it "requires the user to own the organization" do
        log_in_as :organization
        put :update, :id => @org.to_param, :organization => attributes_for(:organization)
        response.should redirect_to(root_url)
      end
    end

    describe "with invalid params" do
      it "assigns the organization as @organization" do
        # Trigger the behavior that occurs when invalid params are submitted
        Organization.any_instance.stub(:save).and_return(false)
        put :update, :id => @org.to_param, :organization => attributes_for(:organization)
        assigns(:organization).should eq(@org)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Organization.any_instance.stub(:save).and_return(false)
        put :update, :id => @org.to_param, :organization => attributes_for(:organization)
        response.should render_template("edit")
      end
    end
  end

  describe "POST follow" do
    before :each do
      @org = create :organization
      @user = log_in_as :volunteer
    end

    describe "if the user already follows the organizaton" do
      before :each do
        create :follow, :organization => @org, :volunteer => @user
      end

      it "redirects to the organization" do
        post :follow, :id => @org.id
        response.should redirect_to(@org)
      end

      it "should not create a follow" do
        expect {
          post :follow, :id => @org.id
        }.to change(Follow, :count).by(0)
      end
    end

    describe "if the user does not follow the organization" do
      it "creates a new Follow" do
        expect {
          post :follow, :id => @org.id
        }.to change(Follow, :count).by(1)
      end

      it "redirects to the organization" do
        post :follow, :id => @org.id
        response.should redirect_to(@org)
      end
    end
  end

  describe 'DELETE unfollow' do
    before :each do
      @org = create :organization
      @user = log_in_as :volunteer
    end

    describe "if the user already follows the organizaton" do
      before :each do
        create :follow, :organization => @org, :volunteer => @user
      end

      it "deletes the follow" do
        delete :unfollow, :id => @org.id
        Follow.where(:volunteer_id => @user.id, :organization_id => @org.id).
               count.
               should == 0
      end
    end

    describe "if the user does not follow the organization" do
      it "redirects to the organization" do
        delete :unfollow, :id => @org.id
        response.should redirect_to(@org)
      end
    end
  end

end
