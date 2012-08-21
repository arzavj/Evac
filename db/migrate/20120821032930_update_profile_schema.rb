class UpdateProfileSchema < ActiveRecord::Migration
  def up
	  #todo stuff
	  remove_column :users, :verify
	  remove_column :users, :password_salt
	  
	  #Pertainent stuff
	  
	  add_column :users, :blurb, :text, :default => ""
	  add_column :users, :school, :string, :default => ""
	  
	  User.all.each do |u|
		begin
			u.blurb = u.profile.blurb
			u.school = u.profile.School
			u.save
		rescue
			puts "No Profile"
		end
	  end
	  
	  drop_table :profiles
	  remove_column :users, :profile_id
	  
	  change_table :users do |t|
		  t.has_attached_file :picture
	  end
  end

  def down
	  
	  create_table "profiles", :force => true do |t|
		  t.string   "file_name"
		  t.string   "file_type"
		  t.integer  "size"
		  t.binary   "data"
		  t.text     "blurb"
		  t.datetime "created_at"
		  t.datetime "updated_at"
		  t.string   "School"
	  end
	  
	  add_column :users, :profile_id, :integer
	  add_index :users, :profile_id
	  
	  User.all.each do |u|
		  p = Profile.create(:blurb => u.blurb, :School => u.school)
		  u.profile_id = p.id
	  end
	  
	  remove_column :users, :blurb
	  remove_column :users, :school
		  
	  drop_attached_file :users, :picture
	  
	  add_column :users, :verify, :string
	  add_column :users, :password_salt, :string, :default => "",  :null => false
  end
end
