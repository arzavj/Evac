require 'date'

class TokController < ApplicationController

	def ResetQuestion
		question = Question.find(params["qID"])
		question.in_session = true
		question.save
		redirect_to :action => "AskChatRoom", :qID => params["qID"]
	end
	
	def AcceptSchedule
		question = Question.find(params["qID"])
		
		question.schedule_id = params["appointment"]
		
		question.save
		
		VidMail.AppointmentConfirmed(params["qID"]).deliver #send email
		
		redirect_to "/myquestions"
	end
	
  def AskChatRoom
	u = User.where({:email => cookies[:email], :password => cookies[:pass]})

	if u.length == 0
		redirect_to "/ask"
		return
	end

	u = u[0]
	
	session = $opentok.create_session request.remote_addr 
	
	@sessionID = session.session_id

	@token = $opentok.generate_token :session_id => @sessionID

	u.current_session = @sessionID
	u.save

	
	#@sessionID = "1_MX4xMjMyMDgxfjcyLjUuMTY3LjE0OH4yMDEyLTAzLTI3IDE4OjUwOjAxLjg0MjcxNCswMDowMH4wLjQzMjU4MjQyMDk5Mn4"
	#@token = "devtoken"
  end
	
	def pastQuestion
		q = Question.find(params["qID"])
		
		q.notes = params["notes"]
		q.was_answered = true
		
		q.save
	end
	
	def Schedule
		#TODO fill with saving to data and parsing data
		
		(1..3).each do |i|
			s = Schedule.new
			s.question_id = params["qID"]
			if !params[i.to_s].eql?("")
				split = params[i.to_s].split(' ')
				date = Date.strptime(split[0], "%m/%d/%y")
				time = Time.parse(split[1])
				s.appointment = DateTime.new(date.year, date.month, date.day, time.hour, time.min, time.sec)
				s.save
			end
		end
		
		VidMail.AppointmentScheduled(params["qID"]).deliver
		
		redirect_to "/"
	end
	
	def ScheduleAppointment
	end
		
  def GiveChatRoom
	q = Question.find(params["qID"])
	  
	if params["answer"].eql?("true") #still in session
		u = q.user	
		
		#q.destroy
		
		@sessionID = u.current_session
		
		@token = $opentok.generate_token :session_id => @sessionID
		
	else #if offline
		u = User.where({:email => cookies[:email], :password => cookies[:pass]})
		u = u[0]
		q.answer_id = u.id
		q.save
		redirect_to :action=> "ScheduleAppointment", :qID => params["qID"]
	end
	  


	#@sessionID = "1_MX4xMjMyMDgxfjcyLjUuMTY3LjE0OH4yMDEyLTAzLTI3IDE4OjUwOjAxLjg0MjcxNCswMDowMH4wLjQzMjU4MjQyMDk5Mn4"
	#@token = "devtoken"
  end
    
    def SetRank
    end
	
	def leaveQuestion(qID)
		question = Question.find(qID)
		
		question.in_session = false
		
		question.save
	end
	
	def submitStatus
		leaveQuestion(params["qID"])
		render :content_type => 'text/javascript'
	end

end
