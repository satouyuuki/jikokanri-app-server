class User < ApplicationRecord
  validates :email, presence: true
  has_many :months, dependent: :destroy
end