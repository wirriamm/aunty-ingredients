class Order < ApplicationRecord
  # relationship
  belongs_to :user
  belongs_to :payment, optional: true
  belongs_to :listing

  # validation
  validates :quantity_ordered, presence: true, numericality: {only_integer: true, :greater_than_or_equal_to => 0}
end
