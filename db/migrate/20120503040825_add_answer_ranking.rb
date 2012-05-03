class AddAnswerRanking < ActiveRecord::Migration
  def self.up
	change_table :questions do |t|
		t.text "answerer_notes"
		t.integer "ask_rank", :limit => 8
		
	end

	change_table :users do |t|
		t.integer "ask_rank", :limit => 8
		t.integer "ask_sessions"
	end
  end

  def self.down
	remove_column :questions, :answerer_notes
	remove_column :questions, :ask_rank
	remove_column :users, :ask_rank
	remove_column :users, :ask_sessions
  end
end
