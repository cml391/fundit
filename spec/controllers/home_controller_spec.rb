require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "assigns a new volunteer as @volunteer" do
      get :index
      assigns(:volunteer).should be_a_new(Volunteer)
    end
  end

end
