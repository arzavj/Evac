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
	end
	
	def edit
		
		@title = "Edit"
		@user = current_user
	end
	
	def update
		u = current_user
		u.update_attributes(params[:user])
		
		redirect_to "/profiles"
	end
end
