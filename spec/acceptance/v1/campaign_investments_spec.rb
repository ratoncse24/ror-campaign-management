require "rails_helper"

resource "Campaign Investment" do
  header "accept", "application/json"

  # campaign with out investment
  let!(:campaign_1) { create(:campaign, target_amount: 500, investment_multiple: 50, sector: "A") }

  # campaign with 90% raised investment
  let!(:campaign_2) { create(:campaign, target_amount: 100, percentage_raised: 90, investment_multiple: 10, sector: "B") }
  let!(:campaign_2_investment_1) { create :investment, campaign_id: campaign_2.id, investment_amount: 90 }

  # campaign with 100% raised investment
  let!(:campaign_3) { create(:campaign, target_amount: 50, percentage_raised: 100, investment_multiple: 10, sector: "B") }
  let!(:campaign_3_investment_1) { create :investment, campaign_id: campaign_3.id, investment_amount: 50 }

  let(:id) { campaign_1.id }

  post "/api/v1/campaigns/:id/make_investment/" do
    explanation "This API will create a new investment for campaign with valid investment amount"

    with_options required: true do
      parameter :investment_amount, "Investment amount"
    end

    context "201" do

      context "Investment <> Single minimum investment amount" do
        let(:investment_amount) { 50 }
        example "Make Investment", document: :v1 do
          do_request

          expect(status).to eq(201)
        end
      end

      context "Investment <> Multiple investment amount" do
        let(:investment_amount) { 150 }
        example "Make Investment", document: :v1 do
          do_request

          expect(status).to eq(201)
        end
      end
    end

    context "400" do

      context "Investment <> Required parameter nil or blank" do
        let(:investment_amount) { nil }
        example "Make investment  - error - blank", document: :v1 do
          do_request

          response = {
            error: I18n.t('investment.blank_investment_amount')
          }
          expect(parsed_body).to eq(response)
          expect(status).to eq(400)
        end
      end

      context "Investment <> Invalid investment amount" do
        let(:investment_amount) { 20 }
        example "Make investment  - investment amount is not multiple or equal single investment amount", document: :v1 do
          do_request

          response = {
            error: I18n.t('investment.invalid_investment_amount')
          }
          expect(parsed_body).to eq(response)
          expect(status).to eq(400)
        end
      end

      context "Investment <> Invalid investment amount" do
        let(:id) { campaign_2.id }
        let(:investment_amount) { 20 }
        example "Make investment  - Investment amount is getter than the campaign target amount", document: :v1 do
          do_request

          response = {
            error: I18n.t('investment.over_investment_amount')
          }
          expect(parsed_body).to eq(response)
          expect(status).to eq(400)
        end
      end

      context "Investment <> Invalid investment amount" do
        let(:id) { campaign_3.id }
        let(:investment_amount) { 20 }
        example "Make investment  - Campaign has already raised 100% investment", document: :v1 do
          do_request

          response = {
            error: I18n.t('campaign.campaign_target_amount_fulfiled')
          }
          expect(parsed_body).to eq(response)
          expect(status).to eq(400)
        end
      end
    end
  end
end


