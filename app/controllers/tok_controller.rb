class TokController < ApplicationController

  def AskChatRoom
	u = User.where({:email => cookies[:email], :password => cookies[:pass]})

	if u.length == 0
		redirect_to "/ask"
		return
	end

	u = u[0]
	
	@sessionID = $opentok.create_session request.remote_addr 

	@token = $opentok.generate_token :session_id => @sessionID, :role => "subscriber"	

	u.current_session = @sessionID.session_id
	u.save
	
	#@sessionID = "1_MX4xMjMyMDgxfjcyLjUuMTY3LjE0OH4yMDEyLTAzLTI3IDE4OjUwOjAxLjg0MjcxNCswMDowMH4wLjQzMjU4MjQyMDk5Mn4"
	#@token = "devtoken"
  end

  def GiveChatRoom
	u = User.find(params["askID"])
	
	@sessionID = u.current_session

	@token = $opentok.generate_token :session_id => @sessionID, :role => "subscriber" 

	#@sessionID = "1_MX4xMjMyMDgxfjcyLjUuMTY3LjE0OH4yMDEyLTAzLTI3IDE4OjUwOjAxLjg0MjcxNCswMDowMH4wLjQzMjU4MjQyMDk5Mn4"
	#@token = "devtoken"
  end

end
