class Micropost < ActiveRecord::Base
  belongs_to :user
  #microposts will appear according to most recent
  # The arrow symbol takes a block and makes it a Proc
  default_scope -> { order(created_at: desc) }

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
