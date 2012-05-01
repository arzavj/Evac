class VidMail < ActionMailer::Base
  default :from => "noreplyvidactia@gmail.com"
	
	def AppointmentScheduled (qID)
		question = Question.find(qID)
		@asker = question.user
		@appointments = question.schedules
		
		mail(:to => @asker.email, :subject => "Someone Wants To Answer")
	end
	
	def AppointmentConfirmed (qID)
		@question = Question.find(qID)
		@answerer = User.find(@question.answer_id)
		@appointment = Schedule.find(@question.schedule.id)
		
		mail(:to => @answerer.email, :subject => "Schedule Confirmed")
	end
end
