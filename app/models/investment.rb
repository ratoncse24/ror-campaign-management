class Investment < ApplicationRecord
  # associations
  belongs_to :campaign

  # validations
  validates :investment_amount, presence: true, :numericality => true
end
