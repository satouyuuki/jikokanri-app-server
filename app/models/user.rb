class User < ApplicationRecord
  cattr_accessor :current_user
  
  validates :email, presence: true
  has_many :months, dependent: :destroy
end