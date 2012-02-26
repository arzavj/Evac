class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
	t.integer "user_id"
	t.text "question", :null => false
	t.string "tag", :limit => 50
	t.integer "category"
	t.integer "rank", :limit => 5
      t.timestamps
    end
	add_index("questions", "user_id")
  end

  def self.down
    drop_table :questions
  end
end
