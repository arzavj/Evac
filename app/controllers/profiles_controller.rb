class ProfilesController < ApplicationController
	def show
		@title = "Bio"
		if params[:id] != nil
			@user = User.find_by_id(params[:id])
		else
			@user = current_account
		end
		@rank = @user.rating
		@sessions = @user.completed_conversations 
		@missed = @user.missed_conversations
		@profile = @user.profile
	end
    
	def show_image
		user = User.find(params[:id])
		profile = user.profile
		send_data profile.data, :type => 'image/png' #, :disposition => 'inline'      
	end
	
	def edit
		@title = "Edit"
		@user = current_account
		@profile = @user.profile
	end
	
	def update
		u = current_account
		profile = u.profile
		
        pic = params[:profile][:picture]
        
        if(pic != nil)
            profile.file_name = pic.original_filename
            profile.file_type = pic.content_type
            profile.size = pic.size
			
            profile.data = pic.read
			
        end
		profile.blurb = params[:profile][:blurb]
		profile.save
		
		u.age = params[:age].to_i
		u.save
		
		redirect_to "/profiles"
	end
end
