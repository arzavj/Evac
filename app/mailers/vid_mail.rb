class VidMail < ActionMailer::Base
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
		if @question.ask_id == uID
			@asker = User.find(@question.answer_id)
			@answer = User.find(@question.ask_id)
		else
			@asker = User.find(@question.ask_id)
			@answer = User.find(@question.answer_id)
		end
		
		@appointments = @question.schedules
		
		mail(:to => @asker.email, :subject => "Someone Wants To Answer")
	end
	
	def AppointmentConfirmed (qID, uID)
		@question = Question.find(qID)
		if @question.ask_id == uID
			@answerer = User.find(@question.answer_id)
			@asker = User.find(@question.ask_id)
		else
			@answerer = User.find(@question.ask_id)
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
		if @question.ask_id == uID
			@asker = User.find(@question.answer_id)
			@answer = User.find(@question.ask_id)
			else
			@asker = User.find(@question.ask_id)
			@answer = User.find(@question.answer_id)
		end
		
		@appointments = @question.schedules
		
		mail(:to => @answer.email, :subject => "Schedule Sent")
	end
	
	def ConfirmAppointmentConfirmed (qID, uID)
		@question = Question.find(qID)
		if @question.ask_id == uID
			@answerer = User.find(@question.answer_id)
			@asker = User.find(@question.ask_id)
			else
			@answerer = User.find(@question.ask_id)
			@asker = User.find(@question.answer_id)
		end
		@appointment = Schedule.find(@question.schedule_id)
		
		mail(:to => @asker.email, :subject => "Schedule Confirmed")
	end


    def Reminder (qID, uID)
		user = User.find(uID)
		@name = user.firstName + " " + user.lastName
		@question = Question.find(qID)
		@appointment = Schedule.find(@question.schedule_id)
		mail(:to => user.email, :subject => "Reminder").deliver
    end


end
