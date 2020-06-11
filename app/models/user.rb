class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # relationship
  has_many :payments, dependent: :destroy
  has_many :orders, dependent: :destroy
  # Orders cannot be destroyed as seller needs the order info in their payments records
  has_many :listings, dependent: :destroy
  # Note: All dependent: :destroy is for seeding purpose

  # validation
  validates :email, uniqueness: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
