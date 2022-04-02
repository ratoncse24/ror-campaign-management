require "rails_helper"

RSpec.describe Campaign::MakeInvestment, type: :service do
  describe ".call" do
    # create campaigns with partial investment
    let!(:campaign_1) { create(:campaign, target_amount: 500, investment_multiple: 50, sector: "A") }
    let!(:campaign_1_investment_1) { create :investment, campaign_id: campaign_1.id, investment_amount: 50 }
    let!(:campaign_1_investment_2) { create :investment, campaign_id: campaign_1.id, investment_amount: 150 }

    # campaign with 90% raised investment
    let!(:campaign_2) { create(:campaign, target_amount: 100, percentage_raised: 90, investment_multiple: 10, sector: "B") }
    let!(:campaign_2_investment_1) { create :investment, campaign_id: campaign_2.id, investment_amount: 90 }

    # campaign with 100% raised investment
    let!(:campaign_3) { create(:campaign, target_amount: 50, percentage_raised: 100, investment_multiple: 10, sector: "B") }
    let!(:campaign_3_investment_1) { create :investment, campaign_id: campaign_3.id, investment_amount: 50 }

    subject { described_class.call(request_body) }

    context "Valid investment <> with a single unit valid investment amount" do
      let(:request_body) do
        {
          id: campaign_1.id,
          investment_amount: 50
        }
      end

      it { is_expected.to match_array([[:is_error, false]]) }
    end

    context "Valid investment <> with a multiple unit valid investment amount" do
      let(:request_body) do
        {
          id: campaign_1.id,
          investment_amount: 150
        }
      end

      it { is_expected.to match_array([[:is_error, false]]) }
    end

    context "Invalid investment <> Campaign not found" do
      let(:request_body) do
        {
          id: nil,
          investment_amount: 50
        }
      end

      it { is_expected.to match_array([[:is_error, true], [:error, I18n.t('campaign.campaign_not_found')]]) }
    end

    context "Invalid investment <> investment amount is nil" do
      let(:request_body) do
        {
          id: campaign_1.id,
          investment_amount: nil
        }
      end

      it { is_expected.to match_array([[:is_error, true], [:error, I18n.t('investment.blank_investment_amount')]]) }
    end

    context "Invalid investment <> invalid investment amount" do
      let(:request_body) do
        {
          id: campaign_1.id,
          investment_amount: 60
        }
      end

      it { is_expected.to match_array([[:is_error, true], [:error, I18n.t('investment.invalid_investment_amount')]]) }
    end

    context "Invalid investment <> iInvestment amount is getter than the campaign target amount" do
      let(:request_body) do
        {
          id: campaign_2.id,
          investment_amount: 20
        }
      end

      it { is_expected.to match_array([[:is_error, true], [:error, I18n.t('investment.over_investment_amount')]]) }
    end

    context "Invalid investment <> iInvestment amount is getter than the campaign target amount" do
      let(:request_body) do
        {
          id: campaign_3.id,
          investment_amount: 20
        }
      end

      it { is_expected.to match_array([[:is_error, true], [:error, I18n.t('campaign.campaign_target_amount_fulfiled')]]) }
    end

  end
end