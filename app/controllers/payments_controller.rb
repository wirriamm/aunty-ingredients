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
    @payment.save
    #assign payment instance to orders
    @orders = Order.where(user: current_user && payment == null)
    @orders.each do |order|
      order.payment = @payment
    end
    #validate basket can be processed
    if validate_payment_success
      @payment.status = "processing"
      #results in "failed" or "success"
      @orders.each do |order|
        order.completed = true
      end
    else
      @payment.status = "invalid"
    end
    redirect_to payment_path(@payment)
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

# V1: Validate if listing exists
# If listing deleted
# -> delete order (DB)
# V2: Validate order quantity <= listing quantity
# If short of qty
# -> update qty in order (DB)
# -> update qty in view
# V3: Validate order price == listing price per qty
# If price changed
# -> get new price from listing
# -> update order_price_pq of order instance (DB)
# If any of the validation failed,
# - render orders basket view [User Story 5]
#     queries orders table of DB for orders instances
# - with alert to show failed validation and modifications done
# - user can resubmit basket again
# IF VALIDATIONS PASSED
# - Calculate total price, store in transaction instance
# - store user_id in instance too
# Send transaction and get response
# - update status column of transaction instance
# IF transaction status is not confirmed
# - render orders basket view [User Story 5]
# - with alert of message
# IF transcation status is confirmed,
# -> update orders completed field to true
# -> update listing quantities
# -> create new instance of transaction
# Redirect to [User story 10]
