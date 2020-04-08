class Meeting < ApplicationRecord
  belongs_to :user
  default_scope -> { order(start_time: :asc) }
  attr_accessor :start_hour, :start_minute, :start_date
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 200 }
  validates :start_time, presence: true
end
