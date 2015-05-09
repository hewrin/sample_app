class Micropost < ActiveRecord::Base
  belongs_to :user
  #microposts will appear according to most recent
  # The arrow symbol takes a block and makes it a Proc
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  # use validate instead of validates for custom validations
  validate :picture_size

  	private

  	def picture_size
  			if picture.size > 5.megabytes
  				errors.add(:picture, "Should be ledd than 5MB")
  			end
  	end
end
