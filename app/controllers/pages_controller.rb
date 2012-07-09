class PagesController < ApplicationController
	skip_before_filter :require_login, :only => ["home", "privacypolicy", "feedback"]
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
  
	def sortQuestion q
		if q.schedule_id == -1
			if q.answer_id == nil
				@qPendNoAnswer << q
			else
				if q.schedules.any? && q.schedules[0].user_id != @user.id
					@qPendConfirmable << q
				else
					@qPendAnswer << q
				end
			end
		else
			@qConfirmed << q
		end
	end
	
	def deleteQ
		user = current_account
		q = Question.find_by_id(params["qID"])
		if user.questions.include?(q)
			q.deleted = true
			q.save
		end
		redirect_to "/myquestions"
	end
	
	def myquestions
		@user = current_account
		@user.new_questions = 0
		@user.save
		
		@qAsked = Question.where({:user_id => @user.id, :was_answered => false})
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
		
		@qPrev = Question.where({:user_id => @user.id, :was_answered => true, :delete_past_question_ask => false})
		@qPrevAnswer = Question.where({:answer_id => @user.id, :was_answered => true, :delete_past_question_answerer => false})
	end
	
	def feedback
		VidMail.Feedback(params["fname"], params["lname"], params["comment"]).deliver
		redirect_to "/"
	end

	def submitQuestion
		q = Question.new
		u = current_account

		q.user_id = u.id
		q.question = params[:question]
		q.category = Integer(params[:category])
		q.in_session = false
		q.save
		
		redirect_to "/"
	end
	
	def repost
		q = Question.find_by_id(params["qID"])
		q.reposted = true
		q.save
		repost = Question.new
		repost.user_id = current_account.id
		repost.question = q.question
		repost.category = q.category
		repost.in_session = false
		repost.save
		
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

	def getCategory
		redirect_to :action => "give", :category => params[:category]
	end

  def privacyPolicy
    @title = "Privacy Policy"
  end

end
