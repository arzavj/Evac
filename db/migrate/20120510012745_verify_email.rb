class VerifyEmail < ActiveRecord::Migration
  def self.up
	change_table :users do |t|
		t.string "verify"
	end
  end

  def self.down
	remove_column :users, :verify
  end
end
