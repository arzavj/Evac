class SplitName < ActiveRecord::Migration
  def self.up
	change_table :users do |t|
		t.string "firstName", :default => ""
		t.string "lastName", :default => ""
	end

	remove_column :users, :name
  end

  def self.down
	change_table :users do |t|
		t.string "name", :default => ""
	end
	
	remove_column :users, :firstName
	remove_column :users, :lastName
  end
end
