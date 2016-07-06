FactoryGirl.define do
  factory :mud do
    name Faker::App.name
    url Faker::Internet.url
    approved false
  end
end
