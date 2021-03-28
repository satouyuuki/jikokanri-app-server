class TargetList < ApplicationRecord
  validates :target_text, presence: true
  validates :target_num, presence: true, numericality: true
  belongs_to :month
  has_many :week_done_lists, dependent: :destroy
end
