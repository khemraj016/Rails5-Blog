FactoryGirl.define do
  factory :post do
    title { Faker::Name.first_name}
    body { Faker::Lorem.sentence }
    image {Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/image.png')))}
  end
end
