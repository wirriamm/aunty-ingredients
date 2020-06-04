class Payment < ApplicationRecord
  # relationship
  belongs_to :user
  has_many :orders
end
