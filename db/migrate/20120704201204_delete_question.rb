class DeleteQuestion < ActiveRecord::Migration
	def self.up
		add_column :questions, :deleted, :boolean, :default => false
	end

	def self.down
		remove_column :questions, :deleted
	end
end
