class ListingsController < ApplicationController
  before_action :check_user?, only: [ :edit, :update, :destroy ]

  def index
    @listings = Listing.where(user: current_user, delete_status: false)
    @my_orders = retrieve_orders_from_listing
  end

  def show
    @listing = Listing.find(params[:id])
    if @listing.delete_status
      redirect_to listings_path
    else
      @order = Order.new
      @in_cart = check_listing_in_cart?
    end
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user
    @listing.save
    if @listing.save
      redirect_to listing_path(@listing)
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      redirect_to listing_path(@listing)
    else
      render "edit"
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.delete_status = true
    if @listing.save
      redirect_to listings_path
    else
      redirect_to listing_path(@listing), alert: "Error deleting your listing."
    end
  end

  private

  def listing_params
    params.require(:listing).permit(:name, :description, :quantity_available, :listing_price_pq, :photo)
  end

  def check_user?
    @listing = Listing.find(params[:id])
    if @listing.user != current_user
      redirect_to listings_path, alert: "You are not authorized."
    end
  end

  def check_listing_in_cart?
    @listing = Listing.find(params[:id])
    @orders = Order.where(user: current_user, completed: false)
    @orders.each do |order|
      if order.listing == @listing
        return true
      end
    end
    return false
  end

  def retrieve_orders_from_listing
    orders = []
    @listings.each do |listing|
      orders += Order.where(listing: listing, completed: true)
    end
    return orders
  end
end

