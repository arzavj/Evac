module PagesHelper
	
	def calculateFutureDateForQuestion(q)
		if q.first_entry.nil?
			return s.appointment
		else
			if q.first_entry > s.appointment
				return q.first_entry
			else
				return s.appointment
			end
		end
	end
end
