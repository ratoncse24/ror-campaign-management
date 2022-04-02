class V1::CampaignSerializer < ApplicationSerializer
  set_id :id
  attributes :name, :image, :percentage_raised, :sector, :country

  attribute :target_amount do |object|
    "£#{object.target_amount}"
  end

  attribute :investment_multiple do |object|
    "£#{object.investment_multiple}"
  end
end

