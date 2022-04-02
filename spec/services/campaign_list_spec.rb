require "rails_helper"

RSpec.describe Campaign::CampaignList, type: :service do
  describe ".call" do

    # create campaigns
    let!(:campaign_1) { create(:campaign, target_amount: 500, investment_multiple: 50, sector: "A") }
    let!(:campaign_2) { create(:campaign, target_amount: 1000, investment_multiple: 100, sector: "A", country: "USA") }
    let!(:campaign_3) { create(:campaign, target_amount: 100, investment_multiple: 10, sector: "B") }

    # create campaign investments
    let!(:campaign_1_investment_1) { create :investment, campaign_id: campaign_1.id, investment_amount: 50 }
    let!(:campaign_1_investment_2) { create :investment, campaign_id: campaign_1.id, investment_amount: 150 }
    let!(:campaign_2_investment_1) { create :investment, campaign_id: campaign_2.id, investment_amount: 200 }


    subject { described_class.call(query_params) }

    context "Campaign list without filtering" do
      let(:query_params) do
        {
        }
      end

      it { is_expected.to match_array([campaign_1, campaign_2, campaign_3]) }
    end

    context "Campaign list with sector filtering" do
      let(:query_params) do
        {
          sector: "B"
        }
      end

      it { is_expected.to match_array([campaign_3]) }
    end

    context "Campaign list with country filtering" do
      let(:query_params) do
        {
          country: "USA"
        }
      end

      it { is_expected.to match_array([campaign_2]) }
    end

    context "Campaign list with number_of_investment filtering" do
      let(:query_params) do
        {
          number_of_investment: 2
        }
      end

      it { is_expected.to match_array([campaign_1]) }
    end

    context "Campaign list with combined filtering" do
      let(:query_params) do
        {
          sector: "A",
          country: "UK",
          number_of_investment: 2
        }
      end

      it { is_expected.to match_array([campaign_1]) }
    end

  end
end


