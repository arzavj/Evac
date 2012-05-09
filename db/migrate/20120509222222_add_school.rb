class AddSchool < ActiveRecord::Migration
  def self.up
	change_table :profiles do |t|
		t.string "School"
	end
  end

  def self.down
	remove_column :profiles, :School
  end
end
