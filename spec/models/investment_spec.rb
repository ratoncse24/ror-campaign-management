require 'rails_helper'

RSpec.describe Investment, type: :model do
  describe "#associations" do
    it { is_expected.to belong_to(:campaign) }
  end

  describe "#validations" do
    it { is_expected.to validate_presence_of(:investment_amount) }
  end

end
