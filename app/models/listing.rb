class Listing < ApplicationRecord
  belongs_to :user
  has_many :orders # cannot use dependent :destroy, as sold orders cannot be unsold even though the current listing is deleted
  has_one_attached :photo

  validates :name, presence: true
  validates :description, presence: true
  validates :quantity_available, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :listing_price_pq, presence: true, numericality: { greater_than_or_equal_to: 0 }

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :name, :description ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
