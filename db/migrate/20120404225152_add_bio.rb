class AddBio < ActiveRecord::Migration
  def self.up
	change_table :users do |t|
		t.float "rank", :default => 0
		t.integer "sessions", :default => 0
		t.integer "profile_id" 
	end	
	add_index("users", "profile_id")
  end

  def self.down
	remove_column :users, :profile_id
	remove_column :users, :rank
	remove_column :users, :sessions
  end
end
