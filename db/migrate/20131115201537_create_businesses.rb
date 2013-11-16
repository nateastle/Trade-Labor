class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.integer :employer_id		
      t.integer :employee_id
      t.string  :title


      t.timestamps
    end
  end
end
