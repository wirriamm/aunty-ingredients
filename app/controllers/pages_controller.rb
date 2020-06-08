class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    if current_user
      @listings = Listing.where.not(user_id: current_user.id)
    else
      @listings = Listing.all
    end
  end
end
