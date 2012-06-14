class VidMail < ActionMailer::Base
	default :from => "noreplyvidactia@gmail.com" #will change when get a namespace
	
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


    def Reminder
        future = Time.now
        future.hour = future.hour + 24
        schedules = Schedule.where("appointment >= ? AND appointment < ?", Time.now, future)

        schedules.each do |s|
                q = s.question
                asker = q.user
                answer = Question.find(q.answer_id)
                @appointment = s
            
                mail(:to => asker.email, :subject => "Reminder").deliver
                mail(:to => answer.email, :subject => "Reminder").deliver
        end
    end


end
