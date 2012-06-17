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
		
		question.schedule_id = params["appointment" + params["count"]]
		
		question.save
		
		u = User.where({:email => cookies[:email], :password => cookies[:pass]})
		
		VidMail.AppointmentConfirmed(params["qID"], u[0].id).deliver #send email
		VidMail.ConfirmAppointmentConfirmed(params["qID"], u[0].id).deliver #send email
		
		redirect_to "/myquestions?sent=1"
	end
	
	def EnterSession	
		question = Question.find(params["qID"])
		
		if !question.in_session
			session = $opentok.create_session request.remote_addr
			question.current_session = session.session_id 
		end
		
		question.in_session = true
		question.save
	
		if params["uID"].to_i == question.user_id
			redirect_to :action => "AskChatRoom", :qID => params["qID"]
		else
			redirect_to :action => "GiveChatRoom", :qID => params["qID"]
		end
	end
	
  def AskChatRoom
	
	@q = Question.find(params["qID"])  
	
	@sessionID = @q.current_session

	@token = $opentok.generate_token :session_id => @sessionID
	  
	@user = User.where({:email => cookies[:email], :password => cookies[:pass]})[0]
  end
	
	def GiveChatRoom
		@q = Question.find(params["qID"])
			
		@user = User.where({:email => cookies[:email], :password => cookies[:pass]})[0]	
		@sessionID = @q.current_session
			
		@token = $opentok.generate_token :session_id => @sessionID

	end
	
	def pastQuestion
		q = Question.find(params["qID"])

		q.notes = params["notes"]
		q.was_answered = true
		
		q.save
	end
	
	def answerPastQuestion
		q = Question.find(params["qID"])
		
		q.answerer_notes = params["notes"]
		q.was_answered = true
		
		q.save
	end
	
	def delete
		Question.find(params["qID"]).delete
		redirect_to "/pages/myquestions"
	end
	
	def Schedule
			
		question = Question.find(params["qID"])
		
		if question.answer_id == nil
			question.answer_id = User.where({:email => cookies[:email], :password => cookies[:pass]})[0].id
		end
		
		question.schedule_id = -1
		question.save
		
		user = User.where({:email => cookies[:email], :password => cookies[:pass]})[0].id
		
		question.schedules.each do |appointment|
			appointment.destroy
		end
		
		(1..3).each do |i|
			s = Schedule.new
			s.question_id = question.id
			if !params["Slot"+i.to_s].eql?("")
				split = params["Slot"+i.to_s].split(' ')
				date = Date.strptime(split[0], '%m/%d/%Y')
				time = Time.parse(split[1]).utc

				s.appointment = DateTime.new(date.year, date.month, date.day, time.hour, time.min, time.sec)
				s.user_id = user #proposer
				s.save
			end
		end
		
		VidMail.AppointmentScheduled(params["qID"], user).deliver
		VidMail.ConfirmAppointmentScheduled(params["qID"], user).deliver
		
		redirect_to :controller => "pages", :action => "home", :sent => "1"
	end
	
	def ScheduleAppointment
	end
    
    def SetRank
		@numValues = 5
    end
	
	def submitRank
		q = Question.find(params["qID"])
		
		
		if params["user"].to_i == 1 #rank the answerer 
		q.rank = params["rank"]
		answerer = User.find(q.answer_id)
		answerer.rank = ((answerer.rank*answerer.sessions) + q.rank)/(answerer.sessions+1)
		answerer.sessions = answerer.sessions+1
		
		answerer.save
		else #ranks the asker
			
		q.ask_rank = params["rank"]	
		asker = q.user
		asker.ask_rank = ((asker.ask_rank*asker.ask_sessions) + q.ask_rank)/(asker.ask_sessions+1)
		asker.ask_sessions = asker.ask_sessions+1
		
		asker.save
		end
		
		q.save
		
		redirect_to "/"
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
