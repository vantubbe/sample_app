require 'spec_helper'

describe "UserPostPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "user post creation" do
    before { visit root_path }

    describe "with invalid information" do
      it "should not create a user post" do
        expect { click_button "Post" }.not_to change(UserPost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'user_post_message', with: "Lorem ipsum" }
      it "should create a user post" do
        expect { click_button "Post" }.to change(UserPost, :count).by(1)
      end
    end
  end
  
  describe "micropost destruction" do
    before { FactoryGirl.create(:user_post, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link "delete" }.to change(UserPost, :count).by(-1)
      end
    end
  end
  
end
