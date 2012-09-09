class Question < ActiveRecord::Base
	belongs_to :asker, :class_name => "User", :foreign_key => "ask_id"
	belongs_to :answerer, :class_name => "User", :foreign_key => "answer_id"
	has_many :schedules, :dependent => :delete_all
	
	default_scope where(:deleted => false)
	default_scope where(:delete_past_question_ask => false) 
	default_scope where(:delete_past_question_answerer => false) 
	
	scope :unAnswered, where("was_answered = FALSE AND answer_id IS NULL")
	
	scope :category, lambda { |cat|
		unAnswered.where(:category => cat)
	}
	
	def conversationPartner(user)
		return self.asker == user ? self.answerer : self.asker
	end
end
