class PagesController < ApplicationController
	
  def home
    @title = "Home"
  end

  def bio
    @title = "Bio"
  end
  
  def ask
	@saved = Rails.cache.read("saved")
    @title = "Ask For Advice"
  end
  
  def give
	@cat = Rails.cache.read("Category")
	@questions = Question.where(:category => @cat)
    @title = "Provide Words of Wisdom"
  end
  
  def watch
    @title = "View Top Video Sessions"
  end

	def submitQuestion
		q = Question.new
		q.user_id = 1
		q.question = params[:question]
		q.category = Integer(params[:category])
		save = q.save
		Rails.cache.write("saved", save)
		redirect_to "/pages/ask"
	end

	def getCategory
		Rails.cache.write("Category", Integer(params[:category]))
		redirect_to "/pages/give"
	end

end
