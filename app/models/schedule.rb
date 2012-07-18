class Schedule < ActiveRecord::Base
	belongs_to :question
	belongs_to :user
	
	future = Time.now
	future = future + 1.day
	schedules = Schedule.where("appointment >= ? AND appointment < ?", Time.now, future)
	
	def self.reminder 
		future = Time.now
		future = future + 1.day
		questions = Question.where("schedule_id > 0 AND EXISTS (Select * from schedules where questions.schedule_id = schedules.id AND schedules.appointment >= ? AND schedules.appointment < ?)", Time.now, future)
	
		questions.each do |q|
			VidMail.Reminder(q.id, q.ask_id).deliver
			VidMail.Reminder(q.id, q.answer_id).deliver
		end
	end
end

