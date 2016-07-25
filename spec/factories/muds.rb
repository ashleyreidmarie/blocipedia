FactoryGirl.define do
  factory :mud do
    name Faker::Name.first_name
    url Faker::Internet.url
    approved false
  end
end
