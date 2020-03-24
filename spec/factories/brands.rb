FactoryBot.define do
  factory :brand do
    code Faker::Number.number(digits: 4).to_s
    name Faker::Company.name
  end
end
