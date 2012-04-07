class User < ActiveRecord::Base
	belongs_to :profile
	has_many :questions
end
