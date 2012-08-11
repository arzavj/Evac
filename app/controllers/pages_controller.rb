class PagesController < ApplicationController
	
	skip_before_filter :authenticate_user!
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
	  @user = current_user
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
		render :json => @questions.to_json(:include => {:asker => {:methods => [:fullName]}}, :only => [:question, :id])
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
end
