FactoryGirl.define do
  factory :comment do
    user_id { Faker::Number.number(5)}
    body { Faker::Lorem.sentence }
    post_id { Faker::Number.number(5)}
  end
end
