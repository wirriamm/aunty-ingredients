class OrdersController < ApplicationController
  def index
    @orders = Order.where(user: current_user, completed: false)
    @payment = Payment.new
    @total_price = total_price
  end

  def create
    listing = Listing.find(params[:listing_id])
    @order = Order.new(
      user: current_user,
      listing: listing,
<<<<<<< HEAD
      order_price_pq: listing.listing_price_pq,
      quantity_ordered: params[:quantity_ordered]
      )
    if @order.quantity_ordered > @order.listing.quantity_available
      redirect_to listing_path(listing), alert: "Only #{@order.listing.quantity_available} of #{@order.listing.name} is available. Please change the quantity of your order."
    else
      if @order.save
        redirect_to orders_path, notice: "test"
=======
      order_price_pq: listing.listing_price_pq
      # quantity_ordered: params[:quantity_ordered]
      )
    # temporarily create a simple form for quantity
    @order.quantity_ordered = 1
    if @order.quantity_ordered > @order.listing.quantity_available
      redirect_to listing_path(listing), alert: "Only #{@order.listing.quantity_available} of #{@order.listing.name.capitalize} is available. Please change the quantity of your order."
    else
      if @order.save
        redirect_to orders_path, notice: "#{@order.listing.name.capitalize} added to cart"
>>>>>>> a57fdedab75426b15d0ccd2622bb66323dfb9c61
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
    redirect_to orders_path
  end

  private
    def total_price
      sum = 0
      @orders = Order.where(user: current_user, completed: false)
      @orders.each do |order|
        order_price = order.quantity_ordered * order.listing.listing_price_pq
        sum += order_price
      end
      sum
    end
end
