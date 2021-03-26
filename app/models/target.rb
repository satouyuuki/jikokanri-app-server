class Target < ApplicationRecord
  validates :total_time, presence: true
  validates :achieved_text, presence: true
end