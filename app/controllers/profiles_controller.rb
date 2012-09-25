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
		@qPending = Question.where({:ask_id => @user.id, :was_answered => false, :schedule_id => -1, :answer_id => nil})
		@qPast = Question.where("(ask_id = ? OR answer_id = ?) AND was_answered = TRUE", @user.id, @user.id)
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
