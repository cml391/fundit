# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization do
    name "MyString"
    email "MyString"
    password_digest "MyString"
    stripe_token "MyString"
    bio "MyText"
  end
end
