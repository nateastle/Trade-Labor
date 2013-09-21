class CreateSkillToUsers < ActiveRecord::Migration
  def change
    create_table :skills_users, :id => false  do |t|
      t.integer :user_id
      t.integer :skill_id
    end
  end
end
