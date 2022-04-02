class Campaign < ApplicationRecord
  # associations
  has_many :investments, dependent: :delete_all

  # validations
  validates :name, :image, :sector, :country, presence: true
  validates :target_amount, :investment_multiple, presence: true, :numericality => {greater_than: 0}

  after_validation :validate_target_n_investment_amount

  # model scopes methods
  scope :filter_by_sector, ->(sector) { where(sector: sector) }
  scope :filter_by_country, ->(country) { where(country: country) }
  scope :filter_by_number_of_investment, ->(number_of_investment) {
    joins(:investments).group("campaigns.id").having("count(campaign_id) >= ?", number_of_investment)
  }

  def validate_target_n_investment_amount
    errors.add(:target_amount, I18n.t('campaign.invalid_target_n_investment_amount')) if target_amount.nil? || investment_multiple.nil? || target_amount.to_f % investment_multiple.to_f > 0
  end
end
