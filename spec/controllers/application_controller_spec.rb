require 'spec_helper'

# Tests for the ApplicationController.
describe ApplicationController do
  describe 'current_user' do
    it 'should return a current volunteer based on session variables' do
      volunteer = create :volunteer
      session[:user_id] = volunteer.id
      session[:user_type] = 'Volunteer'
      subject.current_user.should == volunteer
    end

    it 'should return a current organization based on session variables' do
      organization = create :organization
      session[:user_id] = organization.id
      session[:user_type] = 'Organization'
      subject.current_user.should == organization
    end

    it 'should return nil if the requisite session vars are not present' do
      volunteer = create :volunteer
      log_out

      # neither var
      subject.current_user.should be_nil

      # no type
      session[:user_id] = volunteer.id
      subject.current_user.should be_nil

      # no id
      session[:user_id] = nil
      session[:user_type] = 'Volunteer'
      subject.current_user.should be_nil
    end

    it 'should return nil if the id is invalid' do
      if Volunteer.count > 0
        nonexistant_id = Volunteer.order(:id).last.id + 1
      else
        nonexistant_id = 99999
      end

      session[:user_id] = nonexistant_id
      session[:user_type] = 'Volunteer'

      subject.current_user.should be_nil
    end

    it 'should cache its results' do
      volunteer = create :volunteer
      session[:user_id] = volunteer.id
      session[:user_type] = 'Volunteer'
      subject.current_user.should == volunteer

      # result should be cached, so we can nuke the session vars and still get
      # volunteer
      session[:user_id] = nil
      session[:user_type] = nil
      subject.current_user.should == volunteer
    end
  end
end
