require 'spec_helper'

describe "follows/show" do
  before(:each) do
    @follow = assign(:follow, stub_model(Follow,
      :volunteer_id => "Volunteer",
      :organization_id => "Organization"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Volunteer/)
    rendered.should match(/Organization/)
  end
end
