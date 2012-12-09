# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:volunteer_email) {|n| "volunteer#{n}@volunteers.com" }

  factory :volunteer do
    name                  "Foo"
    last_name             "Volunteer"
    email                 { FactoryGirl.generate :volunteer_email }
    password              'password'
    password_confirmation { |u| u.password}
  end
end

