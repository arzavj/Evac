require 'rake'
require File.expand_path('../../../config/environment',  __FILE__)

namespace :users do
  desc "Using questions to update profiles"
  task :migrate => :environment do
      puts "Starting to migrate"
	  old_users = OldUser.all
	  old_users.each do |old_user|
		  devise_old_user = User.find(old_user.id)
		  devise_old_user.update_attributes(:password => old_user.password, :password_confirmation => old_user.password)
	  end
  end

end
