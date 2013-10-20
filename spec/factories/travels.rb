# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :travel do
    sequence(:title){ |n| "travel#{n}" }
    startdate Date.today - 3.days
    enddate Date.today
    user

    factory :travel_with_albums do
      after(:create) do |travel, evaluator|
        FactoryGirl.create(:album, travel: travel)
      end
    end
  end
end
