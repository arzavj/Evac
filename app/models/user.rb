class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  # Setup accessible (or protected) attributes for your model
	attr_accessible :email, :password, :password_confirmation, :remember_me, :firstName, :lastName, :profile_id, :provider, :uid
	
	validates_presence_of :firstName, :is => 1
	validates_presence_of :lastName, :is => 1
	belongs_to :profile
	has_many :ask_questions, :class_name => 'Question', :foreign_key => 'ask_id'
	has_many :answer_questions, :class_name => 'Question', :foreign_key => 'answer_id'

	has_many :schedules

	
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
	
	def fullName
		return self.firstName + " " + self.lastName
	end
	
	def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
		data = auth.extra.raw_info
		if user = User.where(:email=>data.email).first
			user
		else
			#Create a user with a stub password
			name_array = data.name.split(" ")
			firstName = name_array.first
			lastName = name_array[1..name_array.length].join("")
			user = User.new(:firstName => firstName, :lastName => lastName, :provider => auth.provider, :uid => auth.uid, :email => data.email,:password => Devise.friendly_token[0,20], :confirmed_at => DateTime.now)
	
			user.confirm!
			user.save!
			user
		end
	end
end
