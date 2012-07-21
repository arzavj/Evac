class PagesController < ApplicationController
	skip_before_filter :require_login, :only => ["home", "privacypolicy", "about"]
	@@categories = ["Politics", "Philosophy", "Entertainment", "Business", "Social Justice", "Education", "Science", "Tutoring", "Sports", "Miscellaneous"]

	def ajaxQuestion
		@questions = Question.where("category = ? AND was_answered = ? AND answer_id IS NULL", params["category"].to_i + 1, false)
		render :json => @questions
	end
	
	
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
 	
	def feedback
		VidMail.Feedback(params["name"], params["email"], params["comment"]).deliver
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


  def privacyPolicy
    @title = "Privacy Policy"
  end
  
  def about
    @title = "Vidactica | Tour"
  end
end
