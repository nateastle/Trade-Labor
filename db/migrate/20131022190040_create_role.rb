class CreateRole < ActiveRecord::Migration
  def up
  	create_table :roles do |t|
      t.string :name
      
      t.timestamps
    end
  end

  def down
  end
end
