class Campaign::CampaignList < ApplicationService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    filter_campaigns
  end

  private
  def filter_campaigns
    campaigns = Campaign.all
    campaigns = campaigns.filter_by_sector(params[:sector]) if params[:sector]
    campaigns = campaigns.filter_by_country(params[:country]) if params[:country]
    campaigns = campaigns.filter_by_number_of_investment(params[:number_of_investment]) if params[:number_of_investment]
    campaigns.order(:id)
  end
end

