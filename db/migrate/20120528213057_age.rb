class Age < ActiveRecord::Migration
  def self.up
	change_table :users do |t|
		t.integer "age", :default => 0
	end
  end

  def self.down
	remove_column :users, :age
  end
end
