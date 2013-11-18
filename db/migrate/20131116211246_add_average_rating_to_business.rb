class AddAverageRatingToBusiness < ActiveRecord::Migration
  def change
  	   add_column :businesses, :average_rating, :decimal, :default => 0, :precision => 6, :scale => 2
  end
end
