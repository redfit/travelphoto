# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :travel do
    title "MyText"
    startdate "2013-10-19"
    enddate "2013-10-19"
    user nil
  end
end
