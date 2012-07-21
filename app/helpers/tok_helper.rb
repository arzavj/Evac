module TokHelper
	
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
