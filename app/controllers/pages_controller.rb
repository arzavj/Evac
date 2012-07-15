class PagesController < ApplicationController
	skip_before_filter :require_login, :only => ["home", "privacypolicy", "about"]
	@@categories = ["Politics", "Philosophy", "Entertainment", "Business", "Social Justice", "Science", "Tutoring", "Sports", "Miscellaneous"]

	
  def home
    @title = "Vidactica"
	  
	  @categories = @@categories  
	  if(params[:category])
		  @cat = Integer(params[:category])
		else
		  @cat = 0
	  end
	  
	  @questions = Question.where(:category => @cat)
	  @user = User.where({:email => cookies[:email], :password => cookies[:pass]})
	  if @user.length > 0
		  @user = @user[0]
	  end
  end

  def bio
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
      #send_data @profile.data, :type => 'image/png', :disposition => 'inline'
  end
    
  def show_image
      user = User.find(params[:id])
      profile = user.profile
      send_data profile.data, :type => 'image/png' #, :disposition => 'inline'      
  end
      
  def editBio
    @title = "Edit"
	@user = current_account
	@profile = @user.profile
  end
 	
	def feedback
		VidMail.Feedback(params["fname"], params["lname"], params["comment"]).deliver
		redirect_to "/"
	end

	def submitQuestion
		q = Question.new
		u = current_account

		q.ask_id = u.id
		q.question = params[:question]
		q.category = Integer(params[:category])
		q.in_session = false
		q.save
		
		redirect_to "/"
	end

	def submitProfile
		u = User.where({:email => cookies[:email], :password => cookies[:pass]})
		u = u[0]
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

		redirect_to "/bio"
	end

  def privacyPolicy
    @title = "Privacy Policy"
  end
  
  def about
    @title = "Vidactica | Tour"
  end
end
