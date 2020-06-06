class OrdersController < ApplicationController
  def index
    @orders = Order.all
    @payment = Payment.new
  end

  def create
    @order = Order.new
    @order.user = current_user
    @order.listing = Listing.find(params[:listing_id])
    @order.order_price_pq = @order.listing.listing_price_pq
    @order.quantity_ordered = 1 # create a simple form for quantity
    @order.payment = @order.user.payment
    if @order.save
      # flash message "added to cart"

    else
      # flash error
    end
  end

  def update
  end

  def destroy
  end
end
