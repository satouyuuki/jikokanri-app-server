class Month < ApplicationRecord
  validates :month, presence: true, numericality: 
  { 
    greater_than_or_equal_to: 1, 
    less_than_or_equal_to: 12 
  }
  validates :year, presence: true, numericality:
  { 
    greater_than_or_equal_to: 2021, 
    less_than_or_equal_to: 2099 
  }
  has_many :weeks, dependent: :destroy
  has_many :target_lists, dependent: :destroy
end