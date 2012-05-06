class Schedule < ActiveRecord::Base
	belongs_to :question
	belongs_to :user
end
