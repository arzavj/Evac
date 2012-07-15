class ConversationsController < ApplicationController
	include ConversationsHelper
	def index
		@user = current_account
		@user.new_questions = 0
		@user.save
		
		@qAsked = Question.where({:ask_id => @user.id, :was_answered => false})
		@qAnswer = Question.where({:answer_id => @user.id, :was_answered => false})
		
		@qPendAnswer = []
		@qPendConfirmable = []
		@qPendNoAnswer = []
		@qConfirmed = []
		
		@qAsked.each do |q|
			sortQuestion q
		end
		
		@qAnswer.each do |q|
			sortQuestion q
		end
		
		@length = @qPendConfirmable.length + @qPendAnswer.length + @qPendNoAnswer.length + @qPendConfirmable.length 
		
		@qPrev = Question.where({:ask_id => @user.id, :was_answered => true, :delete_past_question_ask => false})
		@qPrevAnswer = Question.where({:answer_id => @user.id, :was_answered => true, :delete_past_question_answerer => false})
	end
	
	def delete
		user = current_account
		q = Question.find_by_id(params["qID"])
		if user.questions.include?(q)
			q.deleted = true
			q.save
		end
		redirect_to "/conversations"
	end
	
	def repost
		q = Question.find_by_id(params["qID"])
		q.reposted = true
		q.save
		repost = Question.new
		repost.ask_id = current_account.id
		repost.question = q.question
		repost.category = q.category
		repost.in_session = false
		repost.save
		
		redirect_to "/"
	end
	
	def deletePast
		user = current_account
		question = Question.find(params["qID"])
		
		if question.ask_id == user.id
			question.delete_past_question_ask = true
			else
			question.delete_past_question_answerer = true
		end
		
		question.save
		
		redirect_to "/conversations"
	end
end
