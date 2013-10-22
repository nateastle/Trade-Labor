class CreateRole < ActiveRecord::Migration
  def up
  	create_table :roles do |t|
      t.string :name
      
      t.timestamps
    end

  	Role.all_roles.each { |role_name| Role.create(:name => role_name)}

  end

  def down
  end
end
