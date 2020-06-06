class PaymentsController < ApplicationController
  def index
    @payments = Payment.where(user: current_user)
  end

  def show
    @payment = Payment.find(params[:id])
  end


  #button to pay => post request
  def create
    #create new payment instance
    @payment = Payment.new
    # @payment = Payment.new(payment_params)
    @payment.user = current_user
    @payment.status = "incomplete"
    @payment.total_price = total_price
    @payment.save #embed validation in payment model

    #assign payment instance to orders
      # @orders = Order.where(user: current_user && payment == null)
      # @orders.each do |order|
      # end

    #validate basket can be processed
    if @payment.save
      @payment.status = "processing"
      #results in "failed" or "success"
      @orders.each do |order|
        order.payment = @payment
        order.completed = true
      end
      redirect_to payment_path(@payment)
    else
      render "orders"
    end
  end

  private

    def payment_params
      params.require(:payment).permit(:user, :total_price, :status)
    end

    def total_price
      sum = 0
      @orders = Order.where(user: current_user && @payment == null)
      @orders.each do |order|
        order_price = order.quantity_ordered * order.order_price_pq
        sum += order_price
      end
      sum
    end

    def validate_payment_success
      true
    end

end

