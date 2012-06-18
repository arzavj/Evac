class MoveVideoId < ActiveRecord::Migration
  def self.up
	remove_column :users, :current_session
	add_column :questions, :current_session, :string
  end

  def self.down
	remove_column :questions, :current_session
	add_column :users, :current_session, :string
  end
end
