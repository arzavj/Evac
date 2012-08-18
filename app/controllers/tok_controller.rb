require 'date'

class TokController < ApplicationController
	include TokHelper
	
	def AcceptSchedule
		question = Question.find(params["qID"])
		question.schedule_id = params["appointment" + params["count"]]
		question.save
		
		updateNewQuestion(question)
		
		u = current_user
		
		VidMail.AppointmentConfirmed(params["qID"], u.id).deliver #send email
		VidMail.ConfirmAppointmentConfirmed(params["qID"], u.id).deliver #send email
		
		flash[:notice] = "Your preference has been saved."
		redirect_to "/conversations"
	end
	
	def EnterSession	
		question = Question.find(params["qID"])
		
		if !question.in_session
			session = $opentok.create_session request.remote_addr
			question.current_session = session.session_id 
		end
		
		question.in_session = true
		question.first_entry = DateTime.now
		question.save
	
		if params["uID"].to_i == question.ask_id
			redirect_to :action => "AskChatRoom", :qID => params["qID"]
		else
			redirect_to :action => "GiveChatRoom", :qID => params["qID"]
		end
	end
	
  def AskChatRoom
	@room = 1
	@q = Question.find(params["qID"])  
	
	@sessionID = @q.current_session

	@token = $opentok.generate_token :session_id => @sessionID
	  
	@user = current_user
  end
	
	def GiveChatRoom
		@room = 0
		@q = Question.find(params["qID"])
			
		@user = current_user
		@sessionID = @q.current_session
			
		@token = $opentok.generate_token :session_id => @sessionID

	end
	
	def pastQuestion
		q = Question.find(params["qID"])

		q.notes = params["notes"]
		q.in_session = false
		q.was_answered = true
		
		q.save
	end
	
	def answerPastQuestion
		q = Question.find(params["qID"])
		
		q.answerer_notes = params["notes"]
		q.in_session = false
		q.was_answered = true
		
		q.save
	end
	
	def Schedule
		question = Question.find(params["qID"])
		
		makeSchedules question
		
		flash[:notice] = "Your choices were sent."
		redirect_to "/conversations"
	end
	
	def submitRank
		q = Question.find(params["qID"])
		
		user = nil
		rating = nil
		if params["user"].to_i == 1 #rank the answerer 
			q.rank = params["rating"]
			rating = q.rank
			user = User.find(q.answer_id)
		else #ranks the asker
			q.ask_rank = params["rating"]
			rating = q.ask_rank
			user = q.asker
		end
		
		user.rating = ((user.rating*user.completed_conversations) + rating)/(user.completed_conversations+1)
		user.completed_conversations = user.completed_conversations + 1
		user.save
		
		q.save
		
		u = current_user
		u.points = u.points + 5 + 5*(params["rating"].to_i - 3)
		u.save
		
		redirect_to "/"
	end

	def missedLeave
		q = Question.find(params["qID"])
		
		updateMissed q
		
		q.was_answered = true

		q.save
		
		redirect_to "/conversations"
	end
	
	def missedRepost
		q = Question.find(params["qID"])
		
		updateMissed q
		
		q.was_answered = true
		q.reposted = true
		
		q.save
		
		repost q
		
		redirect_to "/conversations"
	end
	
	def missedSchedule
		q = Question.find(params["qID"])

		updateMissed q
		
		q.was_answered = true
		q.save
		
		newPost = repost q
		newPost.answer_id = q.answer_id == newPost.ask_id ? q.ask_id : q.answer_id
		newPost.save
		
		makeSchedules newPost
		redirect_to "/conversations"
	end
	
	def withoutTimer
		q = Question.find(params["qID"])
		q.in_session = false
		q.save
	end

private
	
	def makeSchedules question
		user = current_user
		
		if question.answer_id == nil
			question.answer_id = user.id
		end
		
		question.schedule_id = -1
		question.save
		
		updateNewQuestion(question)
		
		question.schedules.each do |appointment|
			appointment.destroy
		end
		
		(1..3).each do |i|
			s = Schedule.new
			s.question_id = question.id
			if !params["Slot"+i.to_s].eql?("")
				begin
					s.appointment = DateTime.parse(params["Slot"+i.to_s])
					s.appointment = s.appointment.new_offset(params["timeOffset"].to_i/24.0)
				rescue
				#for heroku
					s.appointment = DateTime.now.utc + 6.minutes
				end
				
				s.user_id = user.id #proposer
				s.save
			end
		end
		
		VidMail.AppointmentScheduled(params["qID"], user.id).deliver
		VidMail.ConfirmAppointmentScheduled(params["qID"], user.id).deliver
		
	end
end
