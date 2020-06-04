class Order < ApplicationRecord
  # relationship
  belongs_to :user
  belongs_to :payment
  belongs_to :listing

  # validation
  validates :quantity_ordered, presence: true, numericality: {only_integer: true}
end
