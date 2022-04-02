class Api::V1::CampaignsController < Api::V1::BaseController
  # GET api/v1/campaigns
  def index
    campaigns = Campaign::CampaignList.call(params).page(page).per(params[:per_page])

    render json: V1::CampaignSerializer.new(campaigns, meta: page_details(campaigns)).serializable_hash.to_json, status: :ok
  end

  # POST api/v1/campaigns/:campaign_id/make_investment
  def make_investment
    begin
      investment = Campaign::MakeInvestment.call(investment_params)

      return render json: { error: investment[:error] }, :status => :bad_request if investment[:is_error]
      head :created
    rescue StandardError => e
      render json: { error: "There is an error while processing the investment. Please try again!" }, :status => :bad_request
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def investment_params
      params.permit(:id, :investment_amount)
    end
end
