class MigratUsers < ActiveRecord::Migration
  def self.up
	old_users = OldUser.all
	old_users.each do |old_user|
		devise_old_user = User.find(old_user.id)
		devise_old_user.update_attributes(:password => old_user.password, :password_confirmation => old_user.password)
	end

	remove_column :users, :password
  end

  def self.down
	add_column :users, :password, :string
  end
end
