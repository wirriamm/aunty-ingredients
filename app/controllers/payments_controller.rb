class PaymentsController < ApplicationController
  def index
    @payments = Payment.where(user: current_user)
  end

  def show
    @payment = Payment.find(params[:id])
    @orders = Order.where(payment: @payment)
  end

  # Validate all orders, if any one fail, return to cart with error message
  # initiate a payment instance
  def create
    @orders = Order.where(user: current_user, completed: false)
    deleted_listings = @orders.reject { |order| listing_exist?(order) }
    insufficient_quantity = @orders.reject { |order| order_quantities_valid?(order) }
    # raise
    if deleted_listings.empty? && insufficient_quantity.empty?
      @payment = Payment.new(payment_params)
      @payment.user = current_user
      @payment.status = "Completed"
      if @payment.save
        update_orders_qty(@orders)
        redirect_to payment_path(@payment)
      else
        redirect_to orders_path, alert: "Failed to confirm transaction"
      end
    else
      msg = build_alert(deleted_listings, insufficient_quantity)
      redirect_to orders_path, alert: msg
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:total_price, :status)
  end

  def listing_exist?(order)
    !order.listing.nil?
  end

  def order_quantities_valid?(order)
    order.quantity_ordered <= order.listing.quantity_available
  end

  def update_orders_qty(orders)
    orders.each do |order|
      order.payment = @payment
      order.completed = true
      order.save
      order.listing.quantity_available -= order.quantity_ordered
      order.listing.save
    end
  end

  def build_alert(deleted_listings, insufficient_quantity)
    if deleted_listings.any?
      deleted = deleted_listings.map { |order| order.listing.name }
      msg1 = pluralize_sentence(deleted) + "been removed from the seller; "
    end
    if insufficient_quantity.any?
      insufficient = insufficient_quantity.map { |order| order.listing.name }
      msg2 = pluralize_sentence(insufficient) + "insufficient stock; "
    end
    "#{msg1}#{msg2}Please edit your cart before checking out again."
  end

  def pluralize_sentence(array)
    plularized = array.length > 1 ? "#{array[0]} has " : "#{array.join(', ')} have "
  end
end
