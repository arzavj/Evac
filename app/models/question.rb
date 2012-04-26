class Question < ActiveRecord::Base
	belongs_to :user
	has_many :schedules, :dependent => :delete_all
end
