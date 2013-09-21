class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.boolean :days
      t.boolean :nights
      t.boolean :weekends

      t.timestamps
    end
  end
end
