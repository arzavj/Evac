class VidMail < ActionMailer::Base
	#default :from => "	" 
    default :from => "noreply@vidactica.com" 
	
	def Welcome(uID)
		@user = User.find(uID)
		
		mail(:to => @user.email, :subject => "Welcome to Vidactica")
	end
	
	def ConfirmEmail(uID)
		@user = User.find(uID)
		
		mail(:to => @user.email, :subject => "Confirm Email")
	end
	
	def AppointmentScheduled (qID, uID)
		@question = Question.find(qID)
		if @question.user.id == uID
			@asker = User.find(@question.answer_id)
			@answer = User.find(@question.user.id)
		else
			@asker = User.find(@question.user.id)
			@answer = User.find(@question.answer_id)
		end
		
		@appointments = @question.schedules
		
		mail(:to => @asker.email, :subject => "Someone Wants To Answer")
	end
	
	def AppointmentConfirmed (qID, uID)
		@question = Question.find(qID)
		if @question.user.id == uID
			@answerer = User.find(@question.answer_id)
			@asker = User.find(@question.user.id)
		else
			@answerer = User.find(@question.user.id)
			@asker = User.find(@question.answer_id)
		end
		@appointment = Schedule.find(@question.schedule_id)
		
		mail(:to => @answerer.email, :subject => "Schedule Confirmed")
	end
	
	def Feedback(fname, lname, comment)
		@comment = comment
		puts "Got Here"
		mail(:to => "feedback@vidactica.com", :subject => "Feedback from " + fname + " " + lname)
	end
	
	def ConfirmAppointmentScheduled (qID, uID)
		@question = Question.find(qID)
		if @question.user.id == uID
			@asker = User.find(@question.answer_id)
			@answer = User.find(@question.user.id)
			else
			@asker = User.find(@question.user.id)
			@answer = User.find(@question.answer_id)
		end
		
		@appointments = @question.schedules
		
		mail(:to => @answer.email, :subject => "Schedule Sent")
	end
	
	def ConfirmAppointmentConfirmed (qID, uID)
		@question = Question.find(qID)
		if @question.user.id == uID
			@answerer = User.find(@question.answer_id)
			@asker = User.find(@question.user.id)
			else
			@answerer = User.find(@question.user.id)
			@asker = User.find(@question.answer_id)
		end
		@appointment = Schedule.find(@question.schedule_id)
		
		mail(:to => @asker.email, :subject => "Schedule Confirmed")
	end


    def Reminder (schedule_id, uID)
		user = User.find(uID)
		@name = user.firstName + " " + user.lastName
		@appointment = Schedule.find(schedule_id)
		mail(:to => User.find(uID).email, :subject => "Reminder").deliver
    end


end
