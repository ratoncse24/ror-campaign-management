FactoryBot.define do
  factory :campaign do
    name { Faker::Name.name }
    image { Faker::LoremFlickr.image }
    target_amount { 100 }
    investment_multiple { 10 }
    sector { "A" }
    country { "UK" }
  end
end
