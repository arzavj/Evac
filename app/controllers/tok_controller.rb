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

  def GiveChatRoom
	q = Question.find(params["qID"])
	q.destroy
	
	u = User.find(params["askID"])
	
	@sessionID = u.current_session

	@token = $opentok.generate_token :session_id => @sessionID

	#@sessionID = "1_MX4xMjMyMDgxfjcyLjUuMTY3LjE0OH4yMDEyLTAzLTI3IDE4OjUwOjAxLjg0MjcxNCswMDowMH4wLjQzMjU4MjQyMDk5Mn4"
	#@token = "devtoken"
  end
	
	def ScheduleAppointment
	end
    
    def SetRank
    end

end
