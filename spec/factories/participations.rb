# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :participation do
    volunteer_id 1
    event_id 1
    note "MyText"
    goal 1
  end
end
