namespace :db do
  namespace :seed do
    task :create_campaigns  => :environment do

      campaign_list = [
        {name: Faker::Name.name, image: Faker::LoremFlickr.image, target_amount: 500, investment_multiple: 100, sector: "A", country: "UK"},
        {name: Faker::Name.name, image: Faker::LoremFlickr.image, target_amount: 1500, investment_multiple: 50, sector: "A", country: "UK"},
        {name: Faker::Name.name, image: Faker::LoremFlickr.image, target_amount: 2500, investment_multiple: 100, sector: "A", country: "UK"},
        {name: Faker::Name.name, image: Faker::LoremFlickr.image, target_amount: 3500, investment_multiple: 500, sector: "A", country: "UK"},
        {name: Faker::Name.name, image: Faker::LoremFlickr.image, target_amount: 400, investment_multiple: 20, sector: "B", country: "UK"},
        {name: Faker::Name.name, image: Faker::LoremFlickr.image, target_amount: 100, investment_multiple: 50, sector: "B", country: "UK"},
        {name: Faker::Name.name, image: Faker::LoremFlickr.image, target_amount: 300, investment_multiple: 10, sector: "B", country: "UK"},
        {name: Faker::Name.name, image: Faker::LoremFlickr.image, target_amount: 500, investment_multiple: 5, sector: "B", country: "UK"},
        {name: Faker::Name.name, image: Faker::LoremFlickr.image, target_amount: 20, investment_multiple: 2, sector: "B", country: "UK"},
        {name: Faker::Name.name, image: Faker::LoremFlickr.image, target_amount: 9, investment_multiple: 3, sector: "B", country: "UK"},
        {name: Faker::Name.name, image: Faker::LoremFlickr.image, target_amount: 21, investment_multiple: 7, sector: "C", country: "UK"},
        {name: Faker::Name.name, image: Faker::LoremFlickr.image, target_amount: 27, investment_multiple: 3, sector: "C", country: "UK"},
        {name: Faker::Name.name, image: Faker::LoremFlickr.image, target_amount: 30, investment_multiple: 30, sector: "C", country: "UK"},
        {name: Faker::Name.name, image: Faker::LoremFlickr.image, target_amount: 60, investment_multiple: 30, sector: "C", country: "UK"},
        {name: Faker::Name.name, image: Faker::LoremFlickr.image, target_amount: 99, investment_multiple: 11, sector: "C", country: "UK"},
        {name: Faker::Name.name, image: Faker::LoremFlickr.image, target_amount: 500, investment_multiple: 50, sector: "C", country: "UK"},
        {name: Faker::Name.name, image: Faker::LoremFlickr.image, target_amount: 500, investment_multiple: 500, sector: "C", country: "UK"},
        {name: Faker::Name.name, image: Faker::LoremFlickr.image, target_amount: 60, investment_multiple: 20, sector: "C", country: "UK"},
        {name: Faker::Name.name, image: Faker::LoremFlickr.image, target_amount: 12, investment_multiple: 2, sector: "C", country: "UK"},
        {name: Faker::Name.name, image: Faker::LoremFlickr.image, target_amount: 500, investment_multiple: 10, sector: "C", country: "UK"},
        {name: Faker::Name.name, image: Faker::LoremFlickr.image, target_amount: 10, investment_multiple: 10, sector: "C", country: "UK"},
        {name: Faker::Name.name, image: Faker::LoremFlickr.image, target_amount: 500, investment_multiple: 10, sector: "C", country: "UK"},
        {name: Faker::Name.name, image: Faker::LoremFlickr.image, target_amount: 300, investment_multiple: 100, sector: "C", country: "UK"},
        {name: Faker::Name.name, image: Faker::LoremFlickr.image, target_amount: 20, investment_multiple: 5, sector: "C", country: "UK"},
      ]

      campaign_list.each do |campaign|
        Campaign.create!( name: campaign[:name],
                          image: campaign[:image],
                          target_amount: campaign[:target_amount],
                          investment_multiple: campaign[:investment_multiple],
                          sector: campaign[:sector],
                          country: campaign[:country]
        )
      end
    end
  end
end