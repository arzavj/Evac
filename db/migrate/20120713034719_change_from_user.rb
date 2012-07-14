class ChangeFromUser < ActiveRecord::Migration
  def self.up
	rename_column :questions, :user_id, :ask_id
  end

  def self.down
	rename_column :questions, :ask_id, :user_id
  end
end
