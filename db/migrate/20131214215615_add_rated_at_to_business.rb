class AddRatedAtToBusiness < ActiveRecord::Migration
  def change
  	add_column :businesses , :rated_at , :datetime
  end
end
