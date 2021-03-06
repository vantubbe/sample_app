require 'spec_helper'

describe "UserPages" do

  subject {page}

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:user_post, user: user, message: "Foo") }
    let!(:m2) { FactoryGirl.create(:user_post, user: user, message: "Bar") }

    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }

    describe "user posts" do
      it { should have_content(m1.message) }
      it { should have_content(m2.message) }
      it { should have_content(user.user_posts.count) }
    end
  end

  describe "signup page" do
    before {visit signup_path}

    it {should have_content('Sign Up')}
    it {should have_title('Sign Up')}
  end

  describe "signup" do

    before {visit signup_path}
    let(:submit) {"Create my account"}

    describe "with invalid information" do
      it "should not create a user" do
        expect {click_button submit}.not_to change(User, :count)
      end

      describe "after validation" do
        before {click_button submit}
        it {should have_title('Sign Up')}
        it {should have_content('error')}
        it {should have_content('Email is invalid')}

      end

    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before {click_button submit}
        let(:user) {User.find_by_email('user@example.com')}

        it {should have_title(user.name)}
        it {should have_selector('div.alert.alert-success', text: 'Welcome') }
        it {should have_content('Sign out')}
      end

    end
  end

  describe "profile page" do
    let(:user) {FactoryGirl.create(:user) }

    before {visit user_path(user)}

    it {should have_content(user.name)}
    it {should have_content(user.name)}
  end

  describe 'edit' do
    let(:user) {FactoryGirl.create(:user)}
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it {should have_content('Update your profile')}
      it {should have_title('Edit User')}
      it {should have_link('change', href: 'http://gravatar.com/emails')}
    end

    describe "with invalid infomation" do
      before {click_button "Save changes"}
      it{should have_content 'error'}
    end

    describe 'with valid information' do
      let(:new_name) {'New Name'}
      let(:new_email) {'new@example.com'}
      before do
        fill_in "Name",         with: new_name
        fill_in "Email",        with: new_email
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
        click_button "Save changes"
      end

      it {should have_title(new_name)}
      it {should have_selector('div.alert.alert-success', text: 'updated') }
      it {should have_link('Sign out', signout_path)}
      specify {expect(user.reload.name).to eq new_name }
      specify {expect(user.reload.email).to eq new_email }

    end

  end

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    describe "pagination" do

      before(:all) { 15.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1, per_page: 15).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do

      it {should_not have_link('delete', href: user_path(User.first))}

      describe "as admin user" do
        let(:admin) {FactoryGirl.create(:admin)}
        before do
          sign_in admin
          visit users_path
        end

        it{ should have_link('delete', href: user_path(User.first)) }
        it 'should be able to delete another user' do
          expect do
            click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end
        it {should_not have_link('delete', href: user_path(admin))}
      end

    end

  end

end

