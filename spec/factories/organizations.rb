# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:org_email) {|n| "org#{n}@orgs.com" }

  factory :organization do
    name                  "Foo Org"
    email                 { FactoryGirl.generate :org_email }
    password              'password'
    password_confirmation { |u| u.password}
    stripe_token          "orgtoken"
    bio                   "Foo Org is a cool nonprofit"
    stripe_pub_key        "orgkey"
  end
end
