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
		
		u = User.where({:email => cookies[:email], :password => cookies[:pass]})
		
		VidMail.AppointmentConfirmed(params["qID"], u[0].id).deliver #send email
		
		redirect_to "/myquestions?sent=1"
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

	@user = u
	#@sessionID = "1_MX4xMjMyMDgxfjcyLjUuMTY3LjE0OH4yMDEyLTAzLTI3IDE4OjUwOjAxLjg0MjcxNCswMDowMH4wLjQzMjU4MjQyMDk5Mn4"
	#@token = "devtoken"
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
		redirect_to "/pages/myquestion"
	end
	
	def Schedule
			
		question = Question.find(params["qID"])
		
		if question.answer_id == nil
			question.answer_id = User.where({:email => cookies[:email], :password => cookies[:pass]})[0].id
			question.save
		end
		
		puts question.answer_id
		
		if question.schedules.any? #if there are existing schedules
			user = question.schedules[0].user_id
			if user == question.user.id
				user = question.answer_id
			else
				user = question.user.id
			end
		else
			user = question.answer_id
		end
		
		question.schedules.each do |appointment|
			appointment.destroy
		end
		
		(1..3).each do |i|
			s = Schedule.new
			s.question_id = question.id
			if !params["Slot"+i.to_s].eql?("")
				split = params["Slot"+i.to_s].split(' ')
				date = Date.strptime(split[0], '%m/%d/%Y')
				time = Time.parse(split[1])

				s.appointment = DateTime.new(date.year, date.month, date.day, time.hour, time.min, time.sec)
				s.user_id = user #proposer
				s.save
			end
		end
		
	
		#TODO change email
		VidMail.AppointmentScheduled(params["qID"], user).deliver
		
		redirect_to :controller => "pages", :action => "home", :sent => "1"
	end
	
	def ScheduleAppointment
		q = Question.find(params["qID"])
		q.schedule_id = -1
		q.save
	end
		
  def GiveChatRoom
	@numValues = 5
	q = Question.find(params["qID"])
	  
	if q.in_session == true #still in session
		u = User.where({:email => cookies[:email], :password => cookies[:pass]})
		u = u[0]
		q.answer_id = u.id
		
		q.save
		
		u = q.user	
		
		#q.destroy
		
		@sessionID = u.current_session
		
		@token = $opentok.generate_token :session_id => @sessionID
		
	else #if offline
		if params["ignore"]
			redirect_to :controller => "pages", :action => myquestions, :offline => "1"
			return
		end
		
		u = User.where({:email => cookies[:email], :password => cookies[:pass]})
		u = u[0]
		redirect_to :action=> "ScheduleAppointment", :qID => params["qID"]
	end
	  


	#@sessionID = "1_MX4xMjMyMDgxfjcyLjUuMTY3LjE0OH4yMDEyLTAzLTI3IDE4OjUwOjAxLjg0MjcxNCswMDowMH4wLjQzMjU4MjQyMDk5Mn4"
	#@token = "devtoken"
  end
    
    def SetRank
		@numValues = 5
    end
	
	def submitRank
		q = Question.find(params["qID"])
		
		
		if params["user"].to_i == 1
		q.rank = params["rank"]
		answerer = User.find(q.answer_id)
		answerer.rank = ((answerer.rank*answerer.sessions) + q.rank)/(answerer.sessions+1)
		answerer.sessions = answerer.sessions+1
		
		answerer.save
		else
			
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
