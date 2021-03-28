class Week < ApplicationRecord
  validates :week, presence: true
  belongs_to :month
  has_many :week_done_lists, dependent: :destroy
end