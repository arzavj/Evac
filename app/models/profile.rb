class Profile < ActiveRecord::Base
	has_one :user
	has_attached_file :picture
end
