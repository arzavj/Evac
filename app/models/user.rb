class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  # Setup accessible (or protected) attributes for your model
	attr_accessible :id, :email, :password, :password_confirmation, :remember_me, :firstName, :lastName, :profile_id, :provider, :uid, :blurb, :picture, :age, :location, :short_bio, :prefered_schedule
	
	validates_presence_of :firstName
	validates_presence_of :lastName
	has_many :ask_questions, :class_name => 'Question', :foreign_key => 'ask_id'
	has_many :answer_questions, :class_name => 'Question', :foreign_key => 'answer_id'

	has_many :schedules
	
	has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "http://placehold.it/140x140"
	
	acts_as_messageable

	
	def questions
		return Question.where("ask_id = ? OR answer_id = ?", self.id, self.id)
	end
	
	def hasMissedQuestion?(question)
		if question.ask_id == self.id
			return question.ask_missed
		elsif question.answer_id == self.id
			return question.answer_missed
		end
	end
	
	def nameWithPoints
		return self.fullName + "(#{self.points})"
	end
	
	def fullName
		return self.firstName + " " + self.lastName
	end
	
	def setUpProfile
		return !self.picture_file_name.nil?
	end
	
	def self.find_for_facebook_oauth(data)
		user = User.find_by_email(data[:email])
		if user
			user.update_attributes({:provider => "facebook", :uid => data[:id]})
			return user
		else
			p = Profile.create
	
			user = User.new(:firstName => data[:first_name], :lastName => data[:last_name], :provider => "facebook", :uid => data[:id], :email => data[:email],:password => Devise.friendly_token[0,20], :profile_id => p.id)
	
			user.confirm!
			user.save!
			return user
		end
	end

	def mailboxer_email(object)
		return nil
	end
end
