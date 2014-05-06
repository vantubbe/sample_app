require 'spec_helper'

describe "user_posts/new" do
  before(:each) do
    assign(:user_post, stub_model(UserPost,
      :user_id => 1,
      :message => "MyString"
    ).as_new_record)
  end

  it "renders new user_post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_posts_path, "post" do
      assert_select "input#user_post_user_id[name=?]", "user_post[user_id]"
      assert_select "input#user_post_message[name=?]", "user_post[message]"
    end
  end
end
