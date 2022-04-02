require "rails_helper"

RSpec.describe Campaign, type: :model do
  describe "#associations" do
    it { is_expected.to have_many(:investments).dependent(:delete_all) }
  end

  describe "#validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:image) }
    it { is_expected.to validate_presence_of(:target_amount) }
    it { is_expected.to validate_numericality_of(:target_amount) }
    it { is_expected.to validate_presence_of(:investment_multiple) }
    it { is_expected.to validate_numericality_of(:investment_multiple) }
    it { is_expected.to validate_presence_of(:sector) }
    it { is_expected.to validate_presence_of(:country) }
  end

  describe "#custom validations" do
    it "validates campaign target_amount and investment_multiple amount when relation is not valid" do
      camp = Campaign.new(target_amount: 100, investment_multiple: 11)
      camp.validate
      expect(camp.errors[:target_amount]).to include(I18n.t('campaign.invalid_target_n_investment_amount'))
    end
  end

  describe "#scopes" do
      context ".filter_by_sector" do
        let!(:campaign_1) { create(:campaign, target_amount: 500, investment_multiple: 50, sector: "A") }
        let!(:campaign_2) { create(:campaign, target_amount: 1000, investment_multiple: 100, sector: "A", country: "USA") }
        let!(:campaign_3) { create(:campaign, target_amount: 100, investment_multiple: 10, sector: "B") }


        subject { described_class.filter_by_sector("A").count }

        it { is_expected.to eq(2) }
        it { is_expected.not_to eq(3) }
      end

      context ".filter_by_country" do
        let!(:campaign_1) { create(:campaign, target_amount: 500, investment_multiple: 50, sector: "A") }
        let!(:campaign_2) { create(:campaign, target_amount: 1000, investment_multiple: 100, sector: "A", country: "USA") }
        let!(:campaign_3) { create(:campaign, target_amount: 100, investment_multiple: 10, sector: "B") }


        subject { described_class.filter_by_country("USA").count }

        it { is_expected.to eq(1) }
        it { is_expected.not_to eq(3) }
      end

      context ".filter_by_number_of_investment" do
        let!(:campaign_1) { create(:campaign, target_amount: 500, investment_multiple: 50, sector: "A") }
        let!(:campaign_2) { create(:campaign, target_amount: 1000, investment_multiple: 100, sector: "A", country: "USA") }
        let!(:campaign_3) { create(:campaign, target_amount: 100, investment_multiple: 10, sector: "B") }

        let!(:campaign_1_investment_1) { create :investment, campaign_id: campaign_1.id, investment_amount: 50 }
        let!(:campaign_1_investment_2) { create :investment, campaign_id: campaign_1.id, investment_amount: 150 }

        subject { described_class.filter_by_number_of_investment(2).length }

        it { is_expected.to eq(1) }
        it { is_expected.not_to eq(3) }
      end

  end
  end
