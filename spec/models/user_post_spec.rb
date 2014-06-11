require 'spec_helper'

describe UserPost do
  let(:user) {FactoryGirl.create(:user)}
  before do
    @userpost = user.user_posts.build(message: 'Lorem ipsum')
  end
  
  subject {@userpost}
  it {should respond_to(:message)}
  it {should respond_to(:user_id)}
  it {should respond_to(:user)}
  its(:user) {should eq user}
  
  it {should be_valid}
  
  describe 'when user id is not present' do
    before {@userpost.user_id = nil}
    it {should_not be_valid}
  end
  
  describe 'when post is too long' do
    before {@userpost.message = 'a' * 141}
    it {should_not be_valid}
  end
  
  describe 'when user_id is not present' do
    before {@userpost.user_id = nil}
    it {should_not be_valid} 
  end
  
  describe 'when post is empty' do
    before {@userpost.message = ' '}
    it {should_not be_valid}
  end
  
end
