class User < ActiveRecord::Base
	belongs_to :profile
	has_many :ask_questions, :class_name => 'Question', :foreign_key => 'ask_id'
	has_many :answer_questions, :class_name => 'Question', :foreign_key => 'answer_id'

	has_many :schedules

	
	def questions
		return Question.where("ask_id = ? OR answer_id = ?", self.id, self.id)
	end
	
	def hasMissedQuestion?(question)
		puts self.id
		if question.ask_id == self.id
			return question.ask_missed
		elsif question.answer_id == self.id
			puts question.question
			puts question.answer_missed
			return question.answer_missed
		end
	end
	
	def fullName
		return self.firstName + " " + self.lastName
	end
end
