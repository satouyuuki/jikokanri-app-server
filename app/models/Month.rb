class Month < ApplicationRecord
  validates :month, presence: true, numericality: {in: 1..12}
  validates :year, presence: true, numericality: {in: 2021..2099}
  has_many :weeks, dependent: :destroy
end