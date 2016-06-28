FactoryGirl.define do
  pw = RandomData.random_sentence
  
  factory :user do
     username RandomData.random_username
     email { Faker::Internet.email }
     password pw
     password_confirmation pw
  end
end
