class DeleteQuestion < ActiveRecord::Migration
	def self.up
		add_column :questions, :deleted, :boolean, :default => false
		add_column :questions, :reposted, :boolean, :default => false
	end

	def self.down
		remove_column :questions, :deleted
		remove_column :questions, :reposted
	end
end
