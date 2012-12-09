require 'spec_helper'


describe ParticipationsController do

  before :each do
    @user = log_in_as :volunteer
    @p = create :participation, :goal => 100, :volunteer => @user
  end

  describe "GET show" do
    before :each do
      @d1 = create :donation, :participation => @p, :amount => 10
      @d2 = create :donation, :participation => @p, :amount => 20
      @od1 = create :offline_donation, :participation => @p, :amount => 30
      @od2 = create :offline_donation, :participation => @p, :amount => 40

      get :show, :id => @p.id, :volunteer_id => @user
    end

    it "assigns the requested participation as @participation" do
      assigns(:participation).should == @p
    end

    it "assigns the volunteer as @volunteer" do
      assigns(:volunteer).should == @p.volunteer
    end

    it "assigns the offline donation percentage as @offline_perc" do
      assigns(:offline_perc).should == 70
    end

    it "assings the online donation percentage as @online_perc" do
      assigns(:online_perc).should == 30
    end

    it "assigns a new donation as @donation" do
      assigns(:donation).should be_a_new(Donation)
    end
  end

  describe "GET new" do
    it "assigns a new participation as @participation" do
      get :new, :volunteer_id => @user.id
      assigns(:participation).should be_a_new(Participation)
    end

    it "requires the user to be a volunteer" do
      log_out
      get :new, :volunteer_id => @user.id
      response.should redirect_to(login_url)

      log_in_as :volunteer
      get :new, :volunteer_id => @user.id
      response.should_not redirect_to(login_url)
    end
  end

  describe "GET edit" do
    it "assigns the requested participation as @participation" do
      get :edit, :id => @p.id, :volunteer_id => @user
      assigns(:participation).should eq(@p)
    end

    it "requires the user to own the participation" do
      log_in_as :volunteer
      get :edit, :id => @p.id, :volunteer_id => @user
      response.should redirect_to(root_url)
    end
  end

  describe "POST create" do
    before :each do
      @evt = create :event
    end

    describe "with valid params" do
      it "creates a new Participation" do
        expect {
          post :create, :event_id => @evt.id, :volunteer_id => @user.id, :participation => attributes_for(:participation)
        }.to change(Participation, :count).by(1)
      end

      it "assigns a newly created participation as @participation" do
        post :create, :event_id => @evt.id, :volunteer_id => @user.id, :participation => attributes_for(:participation)
        assigns(:participation).should be_a(Participation)
        assigns(:participation).should be_persisted
      end

      it "redirects to the created participation" do
        post :create, :event_id => @evt.id, :volunteer_id => @user.id, :participation => attributes_for(:participation)
        response.should redirect_to([@user, Participation.last])
      end

      it "requires the user to be a volunteer" do
        log_out
        post :create, :event_id => @evt.id, :volunteer_id => @user.id, :participation => attributes_for(:participation)
        response.should redirect_to(login_url)

        log_in_as :volunteer
        post :create, :event_id => @evt.id, :volunteer_id => @user.id, :participation => attributes_for(:participation)
        response.should_not redirect_to(login_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved participation as @participation" do
        # Trigger the behavior that occurs when invalid params are submitted
        Participation.any_instance.stub(:save).and_return(false)
        post :create, :event_id => @evt.id, :volunteer_id => @user.id, :participation => attributes_for(:participation)
        assigns(:participation).should be_a_new(Participation)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Participation.any_instance.stub(:save).and_return(false)
        post :create, :event_id => @evt.id, :volunteer_id => @user.id, :participation => attributes_for(:participation)
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested participation" do
        # Assuming there are no other participations in the database, this
        # specifies that the Participation created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Participation.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => @p.id, :volunteer_id => @user, :participation => {'these' => 'params'}
      end

      it "assigns the requested participation as @participation" do
        put :update, :id => @p.id, :volunteer_id => @user, :participation => attributes_for(:participation)
        assigns(:participation).should eq(@p)
      end

      it "redirects to the participation" do
        put :update, :id => @p.id, :volunteer_id => @user, :participation => attributes_for(:participation)
        response.should redirect_to([@user, @p])
      end

      it "requires the user to own the participation" do
        log_in_as :volunteer
        put :update, :id => @p.id, :volunteer_id => @user, :participation => attributes_for(:participation)
        response.should redirect_to(root_url)
      end
    end

    describe "with invalid params" do
      it "assigns the participation as @participation" do
        # Trigger the behavior that occurs when invalid params are submitted
        Participation.any_instance.stub(:save).and_return(false)
        put :update, :id => @p.id, :volunteer_id => @user, :participation => attributes_for(:participation)
        assigns(:participation).should eq(@p)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Participation.any_instance.stub(:save).and_return(false)
        put :update, :id => @p.id, :volunteer_id => @user, :participation => attributes_for(:participation)
        response.should render_template("edit")
      end
    end
  end

  describe 'POST donate' do
    describe "with valid params" do
      it "creates a new Donation" do
        expect {
          post :donate, :id => @p.id, :volunteer_id => @user.id, :donation => attributes_for(:donation)
        }.to change(Donation, :count).by(1)
      end

      it "assigns a newly created donation as @donation" do
        post :donate, :id => @p.id, :volunteer_id => @user.id, :donation => attributes_for(:donation)
        assigns(:donation).should be_persisted
      end

      it "redirects to the participation" do
        post :donate, :id => @p.id, :volunteer_id => @user.id, :donation => attributes_for(:donation)
        response.should redirect_to([@user, @p])
      end

      it "sets the donation's participation to the current participation" do
        post :donate, :id => @p.id, :volunteer_id => @user.id, :donation => attributes_for(:donation)
        Donation.last.participation.should == @p
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved donation as @donation" do
        # Trigger the behavior that occurs when invalid params are submitted
        Donation.any_instance.stub(:save).and_return(false)
        post :donate, :id => @p.id, :volunteer_id => @user.id, :donation => attributes_for(:donation)
        assigns(:donation).should be_a_new(Donation)
      end

      it "re-renders the 'show' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Donation.any_instance.stub(:save).and_return(false)
        post :donate, :id => @p.id, :volunteer_id => @user.id, :donation => attributes_for(:donation)
        response.should render_template("show")
      end
    end
  end

  describe 'GET offline_donate_form' do
    it "assigns a new OfflineDonation as @offline_donation" do
      get :offline_donate_form, :volunteer_id => @user.id, :id => @p.id
      assigns(:offline_donation).should be_a_new(OfflineDonation)
    end
  end

  describe 'POST offline_donate' do
    describe "with valid params" do
      it "creates a new OfflineDonation" do
        expect {
          post :offline_donate, :id => @p.id, :volunteer_id => @user.id, :offline_donation => attributes_for(:offline_donation)
        }.to change(OfflineDonation, :count).by(1)
      end

      it "assigns a newly created offline_donation as @offline_donation" do
        post :offline_donate, :id => @p.id, :volunteer_id => @user.id, :offline_donation => attributes_for(:offline_donation)
        assigns(:offline_donation).should be_persisted
      end

      it "redirects to the participation" do
        post :offline_donate, :id => @p.id, :volunteer_id => @user.id, :offline_donation => attributes_for(:offline_donation)
        response.should redirect_to([@user, @p])
      end

      it "sets the offline_donation's participation to the current participation" do
        post :offline_donate, :id => @p.id, :volunteer_id => @user.id, :offline_donation => attributes_for(:offline_donation)
        OfflineDonation.last.participation.should == @p
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved offline_donation as @offline_donation" do
        # Trigger the behavior that occurs when invalid params are submitted
        OfflineDonation.any_instance.stub(:save).and_return(false)
        post :offline_donate, :id => @p.id, :volunteer_id => @user.id, :offline_donation => attributes_for(:offline_donation)
        assigns(:offline_donation).should be_a_new(OfflineDonation)
      end

      it "re-renders the 'offline_donate_form' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        OfflineDonation.any_instance.stub(:save).and_return(false)
        post :offline_donate, :id => @p.id, :volunteer_id => @user.id, :offline_donation => attributes_for(:offline_donation)
        response.should render_template("offline_donate_form")
      end
    end
  end

  describe 'GET thank_form' do
    it 'renders the thank_form template' do
      get :thank_form, :volunteer_id => @user.id, :id => @p.id, :donation_id => create(:donation).id
      response.should render_template('thank_form')
    end
  end

  describe 'POST thank' do
    before :each do
      @donation = create :donation, :participation => @p
      to = "\"#{@donation.name}\" <#{@donation.email}>"
      from = "\"#{@p.volunteer.name}\" <#{@p.volunteer.email}>"
      subject = "Thank you for supporting me in #{@p.event.name}"
      body = "Foo Body"

      Pony.should_receive(:mail).with({
        :to => to,
        :from => from,
        :subject => subject,
        :body => body
      })
    end

    it "should set thank_you_set to true" do
      post :thank, :id => @p.id, :volunteer_id => @user.id,
                   :donation_id => @donation.id, :donation_type => 'online',
                   :message => 'Foo Body'
      @donation.reload.thank_you_sent.should == true
    end

    it "should redirect to the participation" do
      post :thank, :id => @p.id, :volunteer_id => @user.id,
                   :donation_id => @donation.id, :donation_type => 'online',
                   :message => 'Foo Body'
      response.should redirect_to([@user, @p])
    end
  end
end
