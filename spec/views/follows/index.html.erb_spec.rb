require 'spec_helper'

describe "follows/index" do
  before(:each) do
    assign(:follows, [
      stub_model(Follow,
        :volunteer_id => "Volunteer",
        :organization_id => "Organization"
      ),
      stub_model(Follow,
        :volunteer_id => "Volunteer",
        :organization_id => "Organization"
      )
    ])
  end

  it "renders a list of follows" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Volunteer".to_s, :count => 2
    assert_select "tr>td", :text => "Organization".to_s, :count => 2
  end
end
