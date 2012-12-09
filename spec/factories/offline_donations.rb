# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :offline_donation do
    participation

    amount             10
    name               'Foo Donor'
    email              'foodonor@foocorp.net'
    donation_type      'check'
    is_name_private    false
    is_amount_private  false
    thank_you_sent     false
  end
end
