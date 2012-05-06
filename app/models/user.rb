class User < ActiveRecord::Base
	belongs_to :profile
	has_many :questions
	has_many :schedules
end
