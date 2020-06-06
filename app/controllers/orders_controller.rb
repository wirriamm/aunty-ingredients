class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def create
    listing = Listing.find(params[:listing_id])
    @order = Order.new(
      user: current_user,
      listing: listing,
      order_price_pq: listing.listing_price_pq
      # quantity_ordered: params[:quantity_ordered]
      )
    # temporarily create a simple form for quantity
    @order.quantity_ordered = 7
    if @order.quantity_ordered > @order.listing.quantity_available
      redirect_to listing_path(listing), alert: "Only #{@order.listing.quantity_available} of #{@order.listing.name} is available. Please change the quantity of your order."
    else
      if @order.save
        redirect_to orders_path, notice: "test"
      end
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.quantity_ordered = params[:order][:quantity_ordered]
    @order.save
    redirect_to orders_path
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
  end
end
