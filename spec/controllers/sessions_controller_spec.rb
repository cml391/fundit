require 'spec_helper'

describe SessionsController do

  describe 'GET new' do
    it 'should render the login form' do
      get :new
      response.should render_template('new')
    end
  end

  describe 'POST create' do
    describe 'when logging in a volunteer' do
      before :each do
        @volunteer = create :volunteer
        post :create, :email => @volunteer.email, :password => @volunteer.password
      end

      it 'sets the user_id' do
        session[:user_id].should == @volunteer.id
      end

      it 'sets the user_type' do
        session[:user_type].should == 'Volunteer'
      end
    end

    describe 'when logging in a organization' do
      before :each do
        @organization = create :organization
        post :create, :email => @organization.email, :password => @organization.password
      end

      it 'sets the user_id' do
        session[:user_id].should == @organization.id
      end

      it 'sets the user_type' do
        session[:user_type].should == 'Organization'
      end
    end

    describe 'with invalid credentials' do
      before :each do
        @volunteer = create :volunteer
        post :create, :email => @volunteer.email, :password => 'wrong'
      end

      it 'does not log in the user' do
        session[:user_id].should be_nil
        session[:user_type].should be_nil
      end

      it 're-renders the login form' do
        response.should render_template('new')
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      log_in
      delete :destroy
    end

    it 'should clear the user_id' do
      session[:user_id].should be_nil
    end

    it 'should clear the user_type' do
      session[:user_type].should be_nil
    end

    it 'should redirect to root_url' do
      response.should redirect_to(root_url)
    end
  end
end
