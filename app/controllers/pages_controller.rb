class PagesController < ApplicationController
	
  def home
	Rails.cache.write("saved", false)
    @title = "Home"
  end

  def bio
	Rails.cache.write("saved", false)
    @title = "Bio"
  end
  
  def ask
	@saved = Rails.cache.read("saved")
    @title = "Ask For Advice"
  end
  
  def give
	Rails.cache.write("saved", false)
    @title = "Provide Words of Wisdom"
  end
  
  def watch
	Rails.cache.write("saved", false)
    @title = "View Top Video Sessions"
  end

@saved 

  def submitQuestion
	q = Question.new
	q.user_id = 1
	q.question = params[:question]
	q.category = Integer(params[:category])
	save = q.save
	Rails.cache.write("saved", save)
	redirect_to "/ask"
  end 

end
