require "rails_helper"

resource "Campaigns" do
  header "content-type", "application/json"
  header "accept", "application/json"

  # create campaigns
  let!(:campaign_1) { create(:campaign, target_amount: 500, investment_multiple: 50, sector: "A") }
  let!(:campaign_2) { create(:campaign, target_amount: 1000, investment_multiple: 100, sector: "A", country: "USA") }
  let!(:campaign_3) { create(:campaign, target_amount: 100, investment_multiple: 10, sector: "B") }

  # create campaign investments
  let!(:campaign_1_investment_1) { create :investment, campaign_id: campaign_1.id, investment_amount: 50 }
  let!(:campaign_1_investment_2) { create :investment, campaign_id: campaign_1.id, investment_amount: 150 }
  let!(:campaign_2_investment_1) { create :investment, campaign_id: campaign_2.id, investment_amount: 200 }


  get "/api/v1/campaigns" do
    parameter :page, "Page number"
    parameter :per_page, "Records per page. Default: 10"

    let(:page) { 1 }
    let(:per_page) { 10 }

    context "Campaign list <> without filtering" do
      explanation "This API will return the campaigns list without applying filter"

      example "Campaign list", document: :v1 do
        do_request

        expect(status).to eq(200)
        expect(parsed_body).to eq({
                                    data: [
                                      {
                                        id: campaign_1.id.to_s,
                                        type: "campaign",
                                        attributes: {
                                          name: campaign_1.name,
                                          image: campaign_1.image,
                                          percentage_raised: campaign_1.percentage_raised,
                                          target_amount: "£#{campaign_1.target_amount}",
                                          investment_multiple: "£#{campaign_1.investment_multiple}",
                                          sector: campaign_1.sector,
                                          country: campaign_1.country,
                                        }
                                      },
                                      {
                                      id: campaign_2.id.to_s,
                                      type: "campaign",
                                      attributes: {
                                        name: campaign_2.name,
                                        image: campaign_2.image,
                                        percentage_raised: campaign_2.percentage_raised,
                                        target_amount: "£#{campaign_2.target_amount}",
                                        investment_multiple: "£#{campaign_2.investment_multiple}",
                                        sector: campaign_2.sector,
                                        country: campaign_2.country,
                                      }
                                    },
                                      {
                                      id: campaign_3.id.to_s,
                                      type: "campaign",
                                      attributes: {
                                        name: campaign_3.name,
                                        image: campaign_3.image,
                                        percentage_raised: campaign_3.percentage_raised,
                                        target_amount: "£#{campaign_3.target_amount}",
                                        investment_multiple: "£#{campaign_3.investment_multiple}",
                                        sector: campaign_3.sector,
                                        country: campaign_3.country,
                                      }
                                    }
                                    ],
                                    meta: {
                                      total_pages: 1,
                                      total_objects: 3,
                                      current_page: 1,
                                      first_page: true,
                                      last_page: true
                                    }
                                  })
      end
    end

    context "Campaign list <> with sector filtering" do
      explanation "This API will return the campaigns list after applying sector filter"

      parameter :sector, "Campaign sector value"

      let(:sector) { "A" }
      example "Campaign list by sector", document: :v1 do
        do_request

        expect(status).to eq(200)
        expect(parsed_body).to eq({
                                    data: [
                                      {
                                        id: campaign_1.id.to_s,
                                        type: "campaign",
                                        attributes: {
                                          name: campaign_1.name,
                                          image: campaign_1.image,
                                          percentage_raised: campaign_1.percentage_raised,
                                          target_amount: "£#{campaign_1.target_amount}",
                                          investment_multiple: "£#{campaign_1.investment_multiple}",
                                          sector: campaign_1.sector,
                                          country: campaign_1.country,
                                        }
                                      },
                                      {
                                      id: campaign_2.id.to_s,
                                      type: "campaign",
                                      attributes: {
                                        name: campaign_2.name,
                                        image: campaign_2.image,
                                        percentage_raised: campaign_2.percentage_raised,
                                        target_amount: "£#{campaign_2.target_amount}",
                                        investment_multiple: "£#{campaign_2.investment_multiple}",
                                        sector: campaign_2.sector,
                                        country: campaign_2.country,
                                      }
                                    }
                                    ],
                                    meta: {
                                      total_pages: 1,
                                      total_objects: 2,
                                      current_page: 1,
                                      first_page: true,
                                      last_page: true
                                    }
                                  })
      end
    end

    context "Campaign list <> with country filtering" do
      explanation "This API will return the campaigns list after applying country filter"

      parameter :country, "Campaign country value"

      let(:country) { "USA" }
      example "Campaign list by country", document: :v1 do
        do_request

        expect(status).to eq(200)
        expect(parsed_body).to eq({
                                    data: [
                                      {
                                      id: campaign_2.id.to_s,
                                      type: "campaign",
                                      attributes: {
                                        name: campaign_2.name,
                                        image: campaign_2.image,
                                        percentage_raised: campaign_2.percentage_raised,
                                        target_amount: "£#{campaign_2.target_amount}",
                                        investment_multiple: "£#{campaign_2.investment_multiple}",
                                        sector: campaign_2.sector,
                                        country: campaign_2.country,
                                      }
                                    }
                                    ],
                                    meta: {
                                      total_pages: 1,
                                      total_objects: 1,
                                      current_page: 1,
                                      first_page: true,
                                      last_page: true
                                    }
                                  })
      end
    end

    context "Campaign list <> with number of investment" do
      explanation "This API will return the campaigns list which will have getter than or equal to supplied investment number"

      parameter :number_of_investment, "Number of investment"

      let(:number_of_investment) { 2 }
      example "Campaign list by number of investment", document: :v1 do
        do_request

        expect(status).to eq(200)
        expect(parsed_body).to eq({
                                    data: [
                                      {
                                      id: campaign_1.id.to_s,
                                      type: "campaign",
                                      attributes: {
                                        name: campaign_1.name,
                                        image: campaign_1.image,
                                        percentage_raised: campaign_1.percentage_raised,
                                        target_amount: "£#{campaign_1.target_amount}",
                                        investment_multiple: "£#{campaign_1.investment_multiple}",
                                        sector: campaign_1.sector,
                                        country: campaign_1.country,
                                      }
                                    }
                                    ],
                                    meta: {
                                      total_pages: 1,
                                      total_objects: 1,
                                      current_page: 1,
                                      first_page: true,
                                      last_page: true
                                    }
                                  })
      end
    end

    context "Campaign list <> with combined filtering" do
      explanation "This API will return the campaigns list after applying all the filter"

      parameter :sector, "Campaign sector"
      parameter :country, "Campaign country"
      parameter :number_of_investment, "Number of investment"

      let(:sector) { "A" }
      let(:country) { "UK" }
      let(:number_of_investment) { 1 }
      example "Campaign list by number of investment", document: :v1 do
        do_request

        expect(status).to eq(200)
        expect(parsed_body).to eq({
                                    data: [
                                      {
                                      id: campaign_1.id.to_s,
                                      type: "campaign",
                                      attributes: {
                                        name: campaign_1.name,
                                        image: campaign_1.image,
                                        percentage_raised: campaign_1.percentage_raised,
                                        target_amount: "£#{campaign_1.target_amount}",
                                        investment_multiple: "£#{campaign_1.investment_multiple}",
                                        sector: campaign_1.sector,
                                        country: campaign_1.country,
                                      }
                                    }
                                    ],
                                    meta: {
                                      total_pages: 1,
                                      total_objects: 1,
                                      current_page: 1,
                                      first_page: true,
                                      last_page: true
                                    }
                                  })
      end
    end
  end
end

