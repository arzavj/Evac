class CreateSchedules < ActiveRecord::Migration
  def self.up
    create_table :schedules do |t|
		t.datetime "appointment", :null => false
		t.integer "question_id"
      t.timestamps
    end
	add_index("schedules", "question_id")
  end

  def self.down
    drop_table :schedules
  end
end
