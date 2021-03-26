class TargetList < ApplicationRecord
  validates :target_text, presence: true
  validates :target_num, presence: true, numericality: true
  belongs_to :month
end
