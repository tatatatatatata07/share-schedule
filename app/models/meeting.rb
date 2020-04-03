class Meeting < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 10 }
  validates :content, presence: true, length: { maximum: 200 }
  validates :start_time, presence: true
end
