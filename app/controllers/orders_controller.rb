class OrdersController < ApplicationController
  def index
    @orders = Order.where(user: current_user, completed: false)
    @orders = @orders.select { |order| validate_quantity(order) }
    @payment = Payment.new
    @total_price = total_price
  end

  def create
    listing = Listing.find(params[:listing_id])
    @order = Order.new(
      user: current_user,
      listing: listing,
<<<<<<< HEAD
<<<<<<< HEAD
      order_price_pq: listing.listing_price_pq,
=======
      order_price_pq: listing.listing_price_pq
>>>>>>> orders#index only show orders that belongs to user and also orders that have not been transacted
      quantity_ordered: params[:quantity_ordered]
=======
      order_price_pq: listing.listing_price_pq,
      quantity_ordered: params[:order][:quantity_ordered]
>>>>>>> orders#index validates the quantity against available listing when basket is refreshed
      )
<<<<<<< HEAD
    if @order.quantity_ordered > @order.listing.quantity_available
      redirect_to listing_path(listing), alert: "Only #{@order.listing.quantity_available} of #{@order.listing.name.capitalize} is available. Please change the quantity of your order."
    else
      if @order.save
        redirect_to orders_path, notice: "#{@order.listing.name.capitalize} added to cart"
=======
    if validate_quantity?(@order)
      if @order.save
        redirect_to orders_path, notice: "#{@order.quantity_ordered} #{@order.listing.name} added to your basket."
      else
        redirect_to orders_path, alert: "#{@order.quantity_ordered} #{@order.listing.name} NOT added to your basket."
>>>>>>> refactored orders#create and orders#update
      end
    else
      redirect_to listing_path(listing), alert: "Only #{@order.listing.quantity_available} of #{@order.listing.name} is available. Please change the quantity of your order."
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.quantity_ordered = params[:order][:quantity_ordered]
    if validate_quantity?(@order)
      if @order.save
        redirect_to orders_path, notice: "#{@order.quantity_ordered} #{@order.listing.name} updated in your basket."
      else
        redirect_to orders_path, alert: "#{@order.quantity_ordered} #{@order.listing.name} NOT updated in your basket."
      end
    else
      redirect_to orders_path, alert: "Only #{@order.listing.quantity_available} #{@order.listing.name} available. Please change the quantity of your order."
    end
  end

  def destroy
    Order.find(params[:id]).destroy
    redirect_to orders_path
  end

  private

<<<<<<< HEAD
<<<<<<< HEAD
  def total_price
    sum = 0
    @orders = Order.where(user: current_user, completed: false)
    @orders.each do |order|
      order_price = order.quantity_ordered * order.listing.listing_price_pq
      sum += order_price
    end
    sum
=======
  def validate_quantity(order)
=======
  def validate_quantity?(order)
>>>>>>> refactored orders#create and orders#update
    order.quantity_ordered <= order.listing.quantity_available
>>>>>>> orders#index validates the quantity against available listing when basket is refreshed
  end
end
