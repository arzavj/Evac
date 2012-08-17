module ConversationsHelper
	def sortQuestion q
		if q.schedule_id == -1
			if q.answer_id == nil
				@qPendNoAnswer << q
				else
				if q.schedules.any? && q.schedules[0].user_id != @user.id
					@qPendConfirmable << q
					else
					@qPendAnswer << q
				end
			end
			else
			@qConfirmed << q
		end
	end
	
	def markMissed question
		if question.first_entry.nil?
			question.ask_missed = true
			question.answer_missed = true
			asker = question.asker
			answer = User.find(question.answer_id)
			answer.missed_conversations = answer.missed_conversations + 1
			asker.missed_conversations = asker.missed_conversations + 1
			asker.points = asker.points - 50
			answer.points = answer.points - 50
			asker.save 
			answer.save
		end
		
		question.was_answered = true
		question.save
	end
	
	def calculateFutureDateForQuestion(q, s)
		if q.first_entry.nil?
			return s.appointment
		else
			if q.first_entry > s.appointment
				return q.first_entry
			else
				return s.appointment
			end
		end
	end
end
