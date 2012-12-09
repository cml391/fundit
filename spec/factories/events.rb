# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    organization

    description 'Foo Event is an event.'
    name 'Foo Event'
    date 3.days.from_now
  end
end
