class PagesController < ApplicationController

	@@categories = ["Politics", "Philosophy", "Entertainment", "Business", "Social Justice", "Science", "Tutoring", "Sports", "Miscellaneous"]
	
  def home
    @title = "Home"
	  
	  @categories = @@categories  
	  if(params[:category])
		  @cat = Integer(params[:category])
		else
		  @cat = 0
	  end
	  
	  @questions = Question.where(:category => @cat)

  end

  def bio
    @title = "Bio"
	if params[:id] != nil
		u = User.where({:id => params[:id]})
	else
		u = User.where({:email => cookies[:email], :password => cookies[:pass]})
	end
    @user = u[0]
	@rank = @user.rank*@user.sessions + @user.ask_rank*@user.ask_sessions 
	@sessions = @user.sessions + @user.ask_sessions
	if @sessions == 0
		@rank = 0
	else
		@rank = @rank/@sessions
	end
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
  end
  
  def ask
    @title = "Ask For Advice"
  end
  
  def give
	  @categories = @@categories  
	  @cat = Integer(params[:category])
	  @questions = Question.where(:category => @cat)
	  @title = "Provide Words of Wisdom"
	  
	  redirect_to :action => "home", :category => params[:category]
  end
  
  def watch
    @title = "View Top Video Sessions"
  end
	
	def myquestions
		user = User.where({:email => cookies[:email], :password => cookies[:pass]})
		user = user[0]
		@qAsked = Question.where({:user_id => user.id, :was_answered => false})
		@qAnswer = Question.where({:answer_id => user.id, :was_answered => false})
			
		qPendAnswer = []
		qPendNoAnswer = []
		@qConfirmed = []
		@qAsked.each do |q|
			if q.schedule_id == -1
				if q.answer_id == nil
					qPendNoAnswer << q
				else
					qPendAnswer << q
				end
			else
				@qConfirmed << q
			end
		end
		
		@qAnswer.each do |q|
			if q.schedule_id == -1
				if q.answer_id == nil
					qPendNoAnswer << q
				else
					qPendAnswer << q
				end
			else
				@qConfirmed << q
			end
		end
		
		@qPending = qPendAnswer + qPendNoAnswer
		
		@qPrev = Question.where({:user_id => user.id, :was_answered => true})
		@qPrevAnswer = Question.where({:answer_id => user.id, :was_answered => true})
		@user = user
	end
	
	def feedback
		VidMail.Feedback(params["fname"], params["lname"], params["comment"]).deliver
	end

	def submitQuestion

		
		q = Question.new
		u = User.where({:email => cookies[:email], :password => cookies[:pass]})

		if u.length == 0
			q.user_id = -1
		else
			u = u[0]
			q.user_id = u.id
		end
		q.question = params[:question]
		q.category = Integer(params[:category])
		q.save
		
		if params["sType"].eql?("Submit Post") #TODO to what the actual value becomes
			q.in_session = false
			q.save
			redirect_to "/"
			return
		end
		
		redirect_to :controller => :tok, :action => :AskChatRoom, :qID => q.id
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
		
		u.age = params[:profile][:age]
		u.save

		redirect_to "/bio"
	end

	def getCategory
		redirect_to :action => "give", :category => params[:category]
	end



end
