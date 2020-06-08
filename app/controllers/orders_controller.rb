class OrdersController < ApplicationController
  before_action :set_listing, only: [:create]

  def index
    orders = Order.where(user: current_user, completed: false)
    @removed = orders.reject { |order| validate_quantity?(order) }
    @orders = orders.select { |order| validate_quantity?(order) }
    @payment = Payment.new
    @total_price = total_price
  end

  def create
    if order_exist_in_cart?
      @order = find_existing_order
      @order.quantity_ordered += params[:order][:quantity_ordered].to_i
      @order.save
    else
      @order = Order.new(
        user: current_user,
        listing: @listing,
        order_price_pq: @listing.listing_price_pq,
        quantity_ordered: params[:order][:quantity_ordered]
        )
    end

    if validate_quantity?(@order)
      if @order.save
        redirect_to orders_path, notice: "#{@order.quantity_ordered} #{@order.listing.name} added to your basket."
      else
        redirect_to orders_path, alert: "#{@order.quantity_ordered} #{@order.listing.name} NOT added to your basket."
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

  def total_price
    sum = 0
    @orders = Order.where(user: current_user, completed: false)
    @orders.each do |order|
      order_price = order.quantity_ordered * order.listing.listing_price_pq
      sum += order_price
    end
    return sum
  end

  def validate_quantity?(order)
    order.quantity_ordered <= order.listing.quantity_available
  end

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def find_existing_order
    Order.where(user: current_user,
                listing: @listing,
                completed: false).first
  end

  def order_exist_in_cart?
    find_existing_order ? true : false
  end
end
