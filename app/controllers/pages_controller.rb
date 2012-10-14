class PagesController < ApplicationController
	
	skip_before_filter :authenticate_user!
	before_filter :ADMIN!, :only => :deleteQuestion
	@@categories = ["Politics", "Philosophy", "Entertainment", "Business", "Social Justice", "Education", "Science", "Tutoring", "Sports", "Miscellaneous"]
	
  def home
    @title = "Vidactica"
	  @blueBar = true
	  @categories = @@categories  
	  if(params[:category])
		  @cat = Integer(params[:category])
		else
		  @cat = 0
	  end
	  
	  @questions = Question.where(:category => @cat)
	  if current_user
		  @user = current_user
	  
		  flash[:notice] = "You have been awarded 100 VidactiPoints." if @user.points == 100
		  flash[:warning] = "Please fill in your profile." if !@user.setUpProfile
	  end 
  end
 	
	def feedback
		VidMail.Feedback(params["name"], params["email"], params["comment"]).deliver
		redirect_to "/"
	end

  def privacyPolicy
    @title = "Privacy Policy"
  end
  
  def about
    @title = "Vidactica | Tour"
  end
	
	def ajaxQuestion
		if params["category"].to_i.zero?
			@questions = Question.unAnswered
		else
			@questions = Question.category(params["category"].to_i)
		end
		render :json => @questions.to_json(:include => {:asker => {:only => [:id, :points], :methods => [:fullName]}}, :only => [:question, :id])
	end
	
	def ajaxUserScore
		user = User.find_by_id(params[:id])
		render :json => user.points
	end
	
	def submitQuestion
		q = Question.new
		
		q.ask_id = current_user.id
		q.question = params[:question]
		q.category = params[:category].to_i
		q.in_session = false
		q.save
		
		u = current_user
		u.points = u.points + 5
		u.save
		
		redirect_to "/"
	end
	
	def facebook
		@user= User.find_for_facebook_oauth(params)

		flash[:notice] = I18n.t"devise.omniauth_callbacks.success", :kind=>"Facebook"
		sign_in_and_redirect @user, :event=>:authentication

	end
	
	def fblogin
		@user= User.find_by_uid(params[:userID])
		
		if @user
			flash[:notice] = I18n.t"devise.omniauth_callbacks.success", :kind=>"Facebook"
			sign_in_and_redirect @user, :event=>:authentication
		else
			flash[:error] = "You have not authenticated the app"
			redirect_to root_url
			return
		end
	end
	
	def deleteQuestion
		q = Question.find_by_id(params[:qID])
		q.update_attribute("deleted", true) if q
		redirect_to root_url
	end
end
