class MissedConversation < ActiveRecord::Migration
  def self.up
	rename_column :users, :ask_rank, :rating
	rename_column :users, :ask_sessions, :completed_conversations
	add_column :users, :missed_conversations, :integer, :default => 0
	add_column :questions, :first_entry, :datetime
  end

  def self.down
	rename_column :users, :rating, :ask_rank
	rename_column :users, :completed_conversations, :ask_sessions
	remove_column :users, :missed_conversations
	remove_column :questions, :first_entry
  end
end
