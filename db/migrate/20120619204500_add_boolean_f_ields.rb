class AddBooleanFIelds < ActiveRecord::Migration
  def self.up
	add_column :users, :new_questions, :integer, :default => 0
	add_column :questions, :delete_past_question_ask, :boolean, :default => false
	add_column :questions, :delete_past_question_answerer, :boolean, :default => false
  end

  def self.down
	remove_column :users, :new_questions
	remove_column :questions, :delete_past_question_ask
	remove_column :questions, :delete_past_question_answerer
  end
end
