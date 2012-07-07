class MissedConversation < ActiveRecord::Migration

  def self.up
	rename_column :users, :rank, :rating
	rename_column :users, :ask_sessions, :completed_conversations
	remove_column :users, :ask_rank
	remove_column :users, :sessions
	add_column :users, :missed_conversations, :integer, :default => 0
	add_column :questions, :first_entry, :datetime
  end

  def self.down
	rename_column :users, :rating, :rank
	rename_column :users, :completed_conversations, :ask_sessions
	add_column :users, :ask_rank, :integer, :default => 0
	add_column :users, :sessions, :integer, :default => 0.0
	remove_column :users, :missed_conversations
	remove_column :questions, :first_entry
  end
end
