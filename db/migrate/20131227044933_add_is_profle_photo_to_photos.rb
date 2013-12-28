class AddIsProflePhotoToPhotos < ActiveRecord::Migration
  def change
  	add_column :photos , :is_profile_photo , :boolean , :default => false	
  end
end
