require "rails_helper"

RSpec.describe Api::V1::CampaignsController, type: :routing do
  describe "routing" do
    it "routes to campaign list #index" do
      expect(get: "api/v1/campaigns").to route_to("api/v1/campaigns#index", format: :json)
    end

    it "routes to make a new investment #make_investment" do
      expect(post: "api/v1/campaigns/1/make_investment").to route_to("api/v1/campaigns#make_investment", id: "1", format: :json)
    end
  end
end
