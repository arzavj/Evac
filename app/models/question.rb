class Question < ActiveRecord::Base
	belongs_to :asker, :class_name => "User", :foreign_key => "ask_id"
	belongs_to :answerer, :class_name => "User", :foreign_key => "answer_id"
	has_many :schedules, :dependent => :delete_all
	
	default_scope where(:deleted => false)

end
