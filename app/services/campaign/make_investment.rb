class Campaign::MakeInvestment < ApplicationService
  attr_reader :params, :campaign

  def initialize(params)
    @params = params
  end

  def call
    set_campaign

    return { is_error: true, error: I18n.t('campaign.campaign_not_found') } if campaign.nil?
    return { is_error: true, error: validate_investment_amount[:error] } unless validate_investment_amount.nil?

    ActiveRecord::Base.transaction do
      # create new investment if params are valid
      create_investment
      # update campaign after making new investment
      update_campaign
    end
      { is_error: false }
  end

  private

  def create_investment
    Investment.create!(campaign_id: campaign.id, investment_amount: params[:investment_amount])
  end

  def update_campaign
    total_investment_amount = campaign.investments.sum(:investment_amount)
    percentage_raised = ((total_investment_amount.to_f / campaign.target_amount.to_f) * 100).round(4)

    campaign.update!(percentage_raised: percentage_raised)
  end

  def set_campaign
    @campaign = Campaign.where(id: params[:id]).last
  end

  def validate_investment_amount
    return { error: I18n.t('investment.blank_investment_amount') } if params[:investment_amount].to_f <= 0

    return { error: I18n.t('campaign.campaign_target_amount_fulfiled') } if campaign.percentage_raised >= 100

    return { error: I18n.t('investment.invalid_investment_amount') } if params[:investment_amount].to_f % campaign.investment_multiple > 0

    { error: I18n.t('investment.over_investment_amount') } if (campaign.investments.sum(:investment_amount) + params[:investment_amount].to_f) > campaign.target_amount.to_f
  end
end


