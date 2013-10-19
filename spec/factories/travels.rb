# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :travel do
    sequence(:title){ |n| "travel#{n}" }
    startdate Date.today - 3.days
    enddate Date.today
    user
  end
end
