class Schedule < ActiveRecord::Base
	belongs_to :question
	belongs_to :user
	
	future = Time.now
	future = future + 1.day
	schedules = Schedule.where("appointment >= ? AND appointment < ?", Time.now, future)
	
	def self.reminder 
		future = Time.now
		future = future + 1.day
		schedules = Schedule.where("appointment >= ? AND appointment < ?", Time.now, future)
	
		schedules.each do |s|
			q = s.question
			asker = q.user
			answer = Question.find(q.answer_id)
	
			VidMail.Reminder(s.id, asker.id).deliver
			VidMail.Reminder(s.id, answer.id).deliver
		end
end
