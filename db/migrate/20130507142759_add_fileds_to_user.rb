class AddFiledsToUser < ActiveRecord::Migration
  def change
    add_column :users, :postal_code, :string
    add_column :users, :name, :string
    add_column :users, :last_name, :string
    add_column :users, :first_name, :string
    add_column :users, :address_1, :string
    add_column :users, :address_2, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :contact_phone, :string
    add_column :users, :cell_phone, :string
  end
end
