class ProposeTime < ActiveRecord::Migration
  def self.up
	change_table :schedules do |t|
		t.integer "user_id"
		end
	add_index("schedules", "user_id")
  end

  def self.down
	remove_column :schedules, :user_id
  end
end
