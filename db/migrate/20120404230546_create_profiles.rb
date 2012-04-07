class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
	t.has_attached_file :picture
	t.text "blurb"
      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
