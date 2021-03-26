class Week < ApplicationRecord
  validates :week, presence: true
  belongs_to :month
end