class TokController < ApplicationController

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
	
	def Schedule
		#TODO fill with saving to data and parsing data
		(1..3).each do |i|
			s = Schedule.new
			s.question_id = params["qID"]
			if params[i.to_s]
				s.appointment = DateTime.parse(params[i.to_s])
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
		
		q.destroy
		
		@sessionID = u.current_session
		
		@token = $opentok.generate_token :session_id => @sessionID
		
	else #if offline
		u = User.where({:email => cookies[:email], :password => cookies[:pass]})
		
		q.answer_id = u.id
		
		redirect_to :action=> "ScheduleAppointment", :qID => params["qID"]
	end
	  


	#@sessionID = "1_MX4xMjMyMDgxfjcyLjUuMTY3LjE0OH4yMDEyLTAzLTI3IDE4OjUwOjAxLjg0MjcxNCswMDowMH4wLjQzMjU4MjQyMDk5Mn4"
	#@token = "devtoken"
  end
	
	def ScheduleAppointment
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
		return ""
	end

end
