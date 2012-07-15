module TokHelper
	
	def repost question
		repost = Question.new
		repost.user_id = current_account.id
		repost.question = question.question
		repost.category = question.category
		repost.in_session = false
		repost.save
		
		return repost
	end
	
	def markMissed question
		if question.first_entry.nil?
			question.ask_missed = true
			question.answer_missed = true
			question.was_answered = true
			asker = question.asker
			answer = User.find(question.answer_id)
			answer.missed_conversations = answer.missed_conversations + 1
			asker.missed_conversations = asker.missed_conversations + 1
			question.save
			asker.save
			answer.save
		end
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
