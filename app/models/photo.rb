class Photo < ActiveRecord::Base
  attr_accessible :name, :user_id
belongs_to :user

mount_uploader :name, PhotoFileUploader

end
