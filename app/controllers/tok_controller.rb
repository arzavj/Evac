require 'date'

class TokController < ApplicationController
	include TokHelper
	
	def updateNewQuestion(question)
		asker = question.user
		answer = User.find(question.answer_id)
		asker.new_questions = asker.new_questions + 1
		answer.new_questions = answer.new_questions + 1
		asker.save
		answer.save
	end
	
	def AcceptSchedule
		question = Question.find(params["qID"])
		question.schedule_id = params["appointment" + params["count"]]
		question.save
		
		updateNewQuestion(question)
		
		u = current_account
		
		VidMail.AppointmentConfirmed(params["qID"], u.id).deliver #send email
		VidMail.ConfirmAppointmentConfirmed(params["qID"], u.id).deliver #send email
		
		redirect_to "/myquestions?sent=1"
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
	
		if params["uID"].to_i == question.user_id
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
	  
	@user = current_account
  end
	
	def GiveChatRoom
		@room = 0
		@q = Question.find(params["qID"])
			
		@user = current_account
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
	
	def delete
		user = current_account
		question = Question.find(params["qID"])
		
		if question.user_id == user.id
			question.delete_past_question_ask = true
		else
			question.delete_past_question_answerer = true
		end
		
		question.save
		
		redirect_to "/pages/myquestions"
	end
	
	def makeSchedules question
		user = current_account
		
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
				split = params["Slot"+i.to_s].split(' ')
				date = Date.strptime(split[0], '%m/%d/%Y')
				time = Time.parse(split[1])
				
				s.appointment = DateTime.new(date.year, date.month, date.day, time.hour, time.min, time.sec)
				s.appointment = s.appointment.new_offset(params["timeOffset"].to_i/24.0)
				s.user_id = user.id #proposer
				s.save
			end
		end
		
		VidMail.AppointmentScheduled(params["qID"], user.id).deliver
		VidMail.ConfirmAppointmentScheduled(params["qID"], user.id).deliver
		
	end
	
	def Schedule
		question = Question.find(params["qID"])
		
		makeSchedules question
		
		redirect_to :controller => "pages", :action => "myquestions", :schedule => "1"
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
			user = q.user
		end
		
		user.rating = ((user.rating*user.completed_conversations) + rating)/(user.completed_conversations+1)
		user.completed_conversations = user.completed_conversations + 1
		user.save
		
		q.save
		
		redirect_to "/"
	end

	def missedRepost
		q = Question.find(params["qID"])
		asker = q.user
		answer = User.find(q.answer_id)
		
		if asker.id == current_account.id
			q.answer_missed = true
			answer.missed_conversations = answer.missed_conversations + 1
			asker.rating = ((asker.rating*asker.completed_conversations) + 5.0)/(asker.completed_conversations+1)
			asker.completed_conversations = asker.completed_conversations + 1
		else
			q.ask_missed = true
			asker.missed_conversations = asker.missed_conversations + 1
			answer.rating = ((answer.rating*answer.completed_conversations) + 5.0)/(answer.completed_conversations+1)
			answer.completed_conversations = answer.completed_conversations + 1
		end
		
		q.was_answered = true
		q.reposted = true
		
		asker.save
		answer.save
		q.save
		
		repost q
		
		redirect_to "/myquestions"
	end
	
	def missedSchedule
		q = Question.find(params["qID"])
		asker = q.user
		answer = User.find(q.answer_id)
		
		if asker.id == current_account.id
			q.answer_missed = true
			answer.missed_conversations = answer.missed_conversations + 1
			asker.rating = ((asker.rating*asker.completed_conversations) + 5.0)/(asker.completed_conversations+1)
			asker.completed_conversations = asker.completed_conversations + 1
		else
			q.ask_missed = true
			asker.missed_conversations = asker.missed_conversations + 1
			answer.rating = ((answer.rating*answer.completed_conversations) + 5.0)/(answer.completed_conversations+1)
			answer.completed_conversations = answer.completed_conversations + 1
		end
		
		q.was_answered = true
		
		asker.save
		answer.save
		q.save
		
		newPost = repost q
		newpost.answer_id = q.answer_id
		
		makeSchedules newPost
		newPost.save
		redirect_to "/myquestions"
	end
end
