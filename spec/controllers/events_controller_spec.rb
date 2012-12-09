require 'spec_helper'

describe EventsController do

  before :each do
    @organization = log_in_as :organization
    @event = create :event, :organization => @organization
  end

  describe "GET index" do
    it "assigns upcoming events as @events in order of date" do
      Event.all.each &:destroy
      evt1 = create :event, :date => 2.days.ago
      evt2 = create :event, :date => 4.days.from_now
      evt3 = create :event, :date => 2.days.from_now

      get :index
      assigns(:events).should == [evt3, evt2]
    end
  end

  describe "GET show" do
    it "assigns the requested event as @event" do
      get :show, :id => @event.id, :organization_id => @organization.id
      assigns(:event).should == @event
    end
  end

  describe "GET new" do
    it "assigns a new event as @event" do
      get :new
      assigns(:event).should be_a_new(Event)
    end

    it "requires the user to be logged in as an organization" do
      log_out
      get :new
      response.should redirect_to(root_url)

      log_in_as :organization
      get :new
      response.should_not redirect_to(root_url)
    end
  end

  describe "GET edit" do
    it "assigns the requested event as @event" do
      get :edit, :id => @event.id, :organization_id => @organization.id
      assigns(:event).should == @event
    end

    it "requires the user to own the event" do
      log_in_as :organization
      get :edit, :id => @event.id, :organization_id => @organization.id
      response.should redirect_to(root_url)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Event" do
        expect {
          post :create, :event => attributes_for(:event)
        }.to change(Event, :count).by(1)
      end

      it "assigns a newly created event as @event" do
        post :create, :event => attributes_for(:event)
        assigns(:event).should be_a(Event)
        assigns(:event).should be_persisted
      end

      it "redirects to the created event" do
        post :create, :event => attributes_for(:event)
        response.should redirect_to([@organization, Event.last])
      end

      it "requires the user to be logged in as an organization" do
        log_out
        get :new
        response.should redirect_to(root_url)

        log_in_as :organization
        get :new
        response.should_not redirect_to(root_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved event as @event" do
        # Trigger the behavior that occurs when invalid params are submitted
        Event.any_instance.stub(:save).and_return(false)
        post :create, :event => {}
        assigns(:event).should be_a_new(Event)
        assigns(:event).should_not be_persisted
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Event.any_instance.stub(:save).and_return(false)
        post :create, :event => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested event" do
        # Assuming there are no other events in the database, this
        # specifies that the Event created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Event.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => @event.id, :organization_id => @organization.id, :event => {'these' => 'params'}}
      end

      it "assigns the requested event as @event" do
        put :update, {:id => @event.id, :organization_id => @organization.id, :event => attributes_for(:event)}
        assigns(:event).should eq(@event)
      end

      it "redirects to the event" do
        put :update, {:id => @event.id, :organization_id => @organization.id, :event => attributes_for(:event)}
        response.should redirect_to([@organization, @event])
      end

      it "requires the user to own the event" do
        log_in_as :organization
        get :edit, :id => @event.id, :organization_id => @organization.id
        response.should redirect_to(root_url)
      end
    end

    describe "with invalid params" do
      it "assigns the event as @event" do
        # Trigger the behavior that occurs when invalid params are submitted
        Event.any_instance.stub(:save).and_return(false)
        put :update, {:id => @event.id, :organization_id => @organization.id, :event => {}}
        assigns(:event).should eq(@event)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Event.any_instance.stub(:save).and_return(false)
        put :update, {:id => @event.id, :organization_id => @organization.id, :event => {}}
        response.should render_template("edit")
      end
    end
  end

end
