class ProfilesController < ApplicationController
	def show
		@title = "Bio"
		if params[:id] != nil
			@user = User.find_by_id(params[:id])
		else
			@user = current_user
		end
		@rank = @user.rating
		@sessions = @user.completed_conversations 
		@missed = @user.missed_conversations
		@description = @user.blurb
		@askQuestions = @user.ask_questions.where(:was_answered => true) 
		@answerQuestions = @user.answer_questions.where(:was_answered => true)
	end
	
	def edit
		
		@title = "Edit"
		@user = current_user
	end
	
	def update
		u = current_user
		if !u.setUpProfile
			u.points += 10
		end
		u.update_attributes(params[:user])
		
		if !u.setUpProfile
			u.points -= 10
			u.save
		end
		
		redirect_to "/profiles"
	end
end
