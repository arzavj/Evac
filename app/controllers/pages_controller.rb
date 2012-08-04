class PagesController < ApplicationController
	
	skip_before_filter :authenticate_user!
	@@categories = ["Politics", "Philosophy", "Entertainment", "Business", "Social Justice", "Education", "Science", "Tutoring", "Sports", "Miscellaneous"]
	
  def home
    @title = "Vidactica"
	  
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
		@questions = Question.where("category = ? AND was_answered = ? AND answer_id IS NULL", params["category"].to_i + 1, false)
		render :json => @questions.to_json(:include => {:asker => {:methods => [:fullName]}}, :only => [:question, :id])
	end
	
	def submitQuestion
		q = Question.new
		
		q.ask_id = current_user.id
		q.question = params[:question]
		q.category = params[:category].to_i
		q.in_session = false
		q.save
		
		u.points = u.points + 5
		u.save
		
		redirect_to "/"
	end
end
