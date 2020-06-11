class Payment < ApplicationRecord
  # relationship
  belongs_to :user
  has_many :orders, dependent: :destroy

  # validation
  validates :total_price, presence: true, numericality: true

  #need to add validations here

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
