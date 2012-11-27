require 'spec_helper'

describe "follows/edit" do
  before(:each) do
    @follow = assign(:follow, stub_model(Follow,
      :volunteer_id => "MyString",
      :organization_id => "MyString"
    ))
  end

  it "renders the edit follow form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => follows_path(@follow), :method => "post" do
      assert_select "input#follow_volunteer_id", :name => "follow[volunteer_id]"
      assert_select "input#follow_organization_id", :name => "follow[organization_id]"
    end
  end
end
