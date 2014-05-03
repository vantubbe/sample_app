FactoryGirl.define do
  factory :user do
    name      "Mike Van"
    email     "mike.vant@libid.com"
    password  "foobar"
    password_confirmation "foobar"
  end
end