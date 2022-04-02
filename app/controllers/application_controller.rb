class ApplicationController < ActionController::API
  include PaginationDetails

  PER_PAGE = 10

  def page
    (params[:page].to_i.zero? && 1) || params[:page].to_i
  end

  def per_page
    return PER_PAGE if params[:per_page].blank?

    params[:per_page].to_i
  end
end
