class AddRoleIdToUser < ActiveRecord::Migration
  def change
  	  add_column :users , :role_id , :integer
  	  drop_table :users_roles
  	  drop_table :roles
  end
end
