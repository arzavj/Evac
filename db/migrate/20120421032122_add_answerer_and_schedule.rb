class AddAnswererAndSchedule < ActiveRecord::Migration
  def self.up
	change_table :questions do |t|
		t.integer "answer_id"
		t.integer "schedule_id", :default => 0
	end
  end

  def self.down
	remove_column :questions, :answer_id
	remove_column :questions, :schedule_id
  end
end
