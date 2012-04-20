class AddIsOnline < ActiveRecord::Migration
  def self.up
	change_table :questions do |t|
		t.boolean "in_session", :default => true
	end
  end

  def self.down
	remove_column :questions, :in_session
  end
end
