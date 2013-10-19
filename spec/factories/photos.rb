# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
    sequence(:title){ |n| "photo#{n}" }
    sequence(:comment){ |n| "comment#{n}" }
    image { File.open(Rails.root.join("spec", "files", "favicon.png"))}
    user
    album
  end
end
