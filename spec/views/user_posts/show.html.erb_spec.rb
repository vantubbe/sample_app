require 'spec_helper'

describe "user_posts/show" do
  before(:each) do
    @user_post = assign(:user_post, stub_model(UserPost,
      :user_id => 1,
      :message => "Message"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Message/)
  end
end
