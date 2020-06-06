class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def create
    @order = Order.new
    @order.user = current_user
    @listing = Listing.find(params[:listing_id])
    @order.listing = @listing
    @order.order_price_pq = @order.listing.listing_price_pq

    # create a simple form for quantity
    @order.quantity_ordered = 3
    @order.save
    # if @order.quantity_ordered > @order.listing.quantity_available

    # end
  end

  def update
    @order = Order.find(params[:id])
    @order.quantity_ordered = params[:order][:quantity_ordered]
    @order.save
    redirect_to orders_path
  end

  def destroy

  end
end
