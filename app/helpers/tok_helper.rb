module TokHelper
	
	def updateMissed q
		asker = q.asker
		answer = q.answerer
		
		if asker.id == current_user.id
			q.answer_missed = true
			answer.missed_conversations = answer.missed_conversations + 1
			asker.rating = ((asker.rating*asker.completed_conversations) + 5.0)/(asker.completed_conversations + 1)
			asker.completed_conversations = asker.completed_conversations + 1
			
			answer.points = answer.points - 30
			asker.points = asker.points + 2 + 10
		else
			q.ask_missed = true
			asker.missed_conversations = asker.missed_conversations + 1
			answer.rating = ((answer.rating*answer.completed_conversations) + 5.0)/(answer.completed_conversations + 1)
			answer.completed_conversations = answer.completed_conversations + 1
			
			asker.points = asker.points - 30
			answer.points = answer.points + 2 + 10
		end
		
		asker.save
		answer.save
	end
	
	def updateNewQuestion(question)
		asker = question.asker
		answer = question.answerer
		asker.new_questions = asker.new_questions + 1
		answer.new_questions = answer.new_questions + 1
		asker.save
		answer.save
	end
	
	def repost question
		repost = Question.new
		repost.asker = current_user
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
