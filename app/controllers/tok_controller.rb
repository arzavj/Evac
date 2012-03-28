class TokController < ApplicationController
  def AskChatRoom
	@apiKey = "13568632"
	apiSecret = "576b22cb7f0415a60bba7e9829fbb3739375ded6"

	u = User.where({:email => cookies[:email], :password => cookies[:pass]})

	if u.length == 0
		redirect_to "/ask"
		return
	end

	u = u[0]

	opentok = OpenTok::OpenTokSDK.new @apiKey, apiSecret 
	begin
		@sessionID = opentok.create_session request.remote_addr 
	rescue => e	
	end

	@token = opentok.generate_token :session_id => @sessionID, :role => OpenTok::RoleConstants::SUBSCRIBER 	

	u.current_session = @sessionID
	u.save
	
	#@sessionID = "1_MX4xMjMyMDgxfjcyLjUuMTY3LjE0OH4yMDEyLTAzLTI3IDE4OjUwOjAxLjg0MjcxNCswMDowMH4wLjQzMjU4MjQyMDk5Mn4"
	#@token = "devtoken"
  end

  def GiveChatRoom
	@apiKey = "13568632"
	
	@sessionID = "1_MX4xMjMyMDgxfjcyLjUuMTY3LjE0OH4yMDEyLTAzLTI3IDE4OjUwOjAxLjg0MjcxNCswMDowMH4wLjQzMjU4MjQyMDk5Mn4"
	@token = "devtoken"
  end

end
