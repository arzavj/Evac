class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
	attr_accessible :email, :password, :password_confirmation, :remember_me, :firstName, :lastName, :profile_id
	
	validates_length_of :firstName, :is => 1
	validates_length_of :lastName, :is => 1
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
end
