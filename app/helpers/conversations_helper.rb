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
end
