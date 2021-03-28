class WeekDoneList < ApplicationRecord
  validates :done_num, presence: true, numericality: true

  belongs_to :target_list
  belongs_to :week
end
