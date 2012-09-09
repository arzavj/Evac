class AddToProfile < ActiveRecord::Migration
  def change
	  add_column :users, :location, :string
	  add_column :users, :prefered_schedule, :string
	  add_column :users, :short_bio, :string
  end
end
