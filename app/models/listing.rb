class Listing < ApplicationRecord
  belongs_to :user
  has_one_attached :picture
  has_many :orders

  validates :name, presence: true
  validates :description, presence: true
  validates :quantity_available, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :listing_price_pq, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
