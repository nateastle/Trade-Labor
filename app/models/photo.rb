class Photo < ActiveRecord::Base
  attr_accessible :name, :user_id , :is_profile_photo
  belongs_to :user

  mount_uploader :name, PhotoFileUploader

  scope :profile_photo , where("is_profile_photo = ?",true)

  validates_presence_of :name, :message => "Please choose the file."

  def is_profile_picture?
 	 is_profile_photo
  end	

  def is_not_profile_picture?
 	 !is_profile_photo
  end	
end
