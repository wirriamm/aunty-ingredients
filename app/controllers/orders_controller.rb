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
    @order.quantity_ordered = 6

    if @order.quantity_ordered > @order.listing.quantity_available

    end
  end

  def update
  end

  def destroy
  end
end
