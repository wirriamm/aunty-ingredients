class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
<<<<<<< HEAD

  # relationship
  has_many :payments
  has_many :orders
=======
  has_many :listings, dependent: :destroy

  validates :email, uniqueness: true
>>>>>>> bd9c008d54d885f54e824283db4aab90850e5073
end
