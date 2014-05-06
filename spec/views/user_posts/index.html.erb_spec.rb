require 'spec_helper'

describe "user_posts/index" do
  before(:each) do
    assign(:user_posts, [
      stub_model(UserPost,
        :user_id => 1,
        :message => "Message"
      ),
      stub_model(UserPost,
        :user_id => 1,
        :message => "Message"
      )
    ])
  end

  it "renders a list of user_posts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Message".to_s, :count => 2
  end
end
