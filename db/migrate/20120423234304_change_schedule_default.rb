class ChangeScheduleDefault < ActiveRecord::Migration
  def self.up
	change_column("questions", "schedule_id", :integer, :default => -1)
  end

  def self.down
	change_column("questions", "schedule_id", :integer, :default => 0)
  end
end
