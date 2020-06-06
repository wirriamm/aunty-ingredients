
class PaymentsController < ApplicationController
  def index
    @payments = Payment.where(user: current_user)
  end

  def show
    @payment = Payment.find(params[:id])
    @orders = Order.where(payment: @payment)
  end


  #button to pay => post request
    def create
    #create new payment instance
    # @payment = Payment.new
    @payment = Payment.new(payment_params)
    @payment.user = current_user
    # @payment.status = "incomplete"
    @payment.save #embed validation in payment model

    #assign payment instance to orders
      # @orders = Order.where(user: current_user && payment == null)
      # @orders.each do |order|
      # end

    #validate basket can be processed
    if @payment.save
      @payment.status = "Processing" #take status from payment gateway
      @payment.save
      #results in "failed" or "success"

      #need to link payment to orders (but cannot get order object)
      @orders = Order.where(user: current_user, completed: false)
      @orders.each do |order|
        order.payment = @payment
        order.completed = true
        order.save
      end


      redirect_to payment_path(@payment)
    else
      render "orders/index"
    end
  end
  private

    def payment_params
      params.require(:payment).permit(:user, :total_price, :status)
    end

    def validate_payment_success
      true
    end

end

# <% @payments.orders.each do |order| %>
#   <%= order.listing.name  %>
#   <%= order.quantity_ordered %>
# <% end %>
