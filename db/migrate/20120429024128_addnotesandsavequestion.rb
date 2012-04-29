class Addnotesandsavequestion < ActiveRecord::Migration
  def self.up
	change_table :questions do |t|
		t.text "notes"
		t.boolean "was_answered", :default => false
	end
  end

  def self.down
	remove_column :questions, :notes
	remove_column :questions, :was_answered
  end
end
