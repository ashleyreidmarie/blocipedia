FactoryGirl.define do
  pw = Faker::Internet.password(8)
  
  factory :user do
    sequence(:username, 'a'){|n| "#{Faker::Name.name}" + n }
    email { Faker::Internet.email }
    password pw
    password_confirmation pw
  end
end
