class ListingsController < ApplicationController
  def index
    @listings = Listing.all
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(params.require(:listing).permit(:name, :description, :quantity_available, :listing_price_pq))
    @listing.user = current_user
    @listing.save
    if @listing.save
      redirect_to listing_path(@listing)
    else
      render "new"
    end
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    @listing.update(params.require(:listing).permit(:name, :description, :quantity_available, :listing_price_pq))
    if @listing.update(params.require(:listing).permit(:name, :description, :quantity_available, :listing_price_pq))
      redirect_to listing_path(@listing)
    else
      render "edit"
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to listings_path
  end
end
