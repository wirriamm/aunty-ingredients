class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  # after_action :redirect_search, only: :home

  def home
    # if current_user
    #   @listings = Listing.where.not(user_id: current_user.id)
    if params[:query].present?
      @listings = Listing.global_search(params[:query])
      # @listings = search_results.searchable
    else
      @listings = Listing.all.order("updated_at").reverse_order
    end
  end

  private

  def redirect_search
    redirect_to root_path(@listings, anchor: "search_anchor")
  end
end
