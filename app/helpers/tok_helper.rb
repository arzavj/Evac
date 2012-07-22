module TokHelper
	
	def updateNewQuestion(question)
		asker = question.asker
		answer = User.find(question.answer_id)
		asker.new_questions = asker.new_questions + 1
		answer.new_questions = answer.new_questions + 1
		asker.save
		answer.save
	end
	
	def repost question
		repost = Question.new
		repost.asker = current_account
		repost.question = question.question
		repost.category = question.category
		repost.in_session = false
		repost.save
		
		return repost
	end
	
	def secondsBefore(qID)
		question = Question.find(qID)
		appointment = Schedule.find(question.schedule_id).appointment
		enter = question.first_entry
		seconds = (appointment - enter).to_i
		if seconds < 0
			return 0
		else
			return seconds
		end
	end
end
