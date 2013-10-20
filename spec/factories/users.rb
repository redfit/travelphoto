FactoryGirl.define do
  factory :user do
    sequence(:email){ |n| "test#{n}@example.com"  }
    password "P@ssw0rd"
    sequence(:username){ |n| "test#{n}"  }
    confirmed_at Date.today
    confirmation_token nil

    factory :user_with_travel do
      after(:create) do |user, evaluator|
        FactoryGirl.create(:travel, user: user)
      end
    end

    factory :user_with_10_travels do
      after(:create) do |user, evaluator|
        FactoryGirl.create_list(:travel, 10, user: user)
      end
    end
  end
end
