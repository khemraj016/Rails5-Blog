FactoryGirl.define do
  factory :user do
    name { Faker::Name.first_name }
    email { "#{name}@example.com" }
    password { Faker::Lorem.sentence }
  end
end

