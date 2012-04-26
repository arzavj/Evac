class VidMail < ActionMailer::Base
  default :from => "noreplyvidactia@gmail.com"
	
	def AppointmentScheduled (qID)
		question = Question.find(qID)
		@asker = question.user
		@appointments = question.schedules
		
		mail(:to => @asker.email, :subject => "Someone Wants To Answer")
	end
end
