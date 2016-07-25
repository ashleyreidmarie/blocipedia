FactoryGirl.define do
  factory :wiki do
    name Faker::Name.first_name
    description Faker::Hipster.paragraph
    private false
    user nil
    mud nil
  end
end
