class Payment < ApplicationRecord
  # relationship
  belongs_to :user
  has_many :orders, optional: true

  # validation
  validates :total_price, presence: true, numericality: true

end
