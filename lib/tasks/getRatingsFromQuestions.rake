require 'rake'
require File.expand_path('../../../config/environment',  __FILE__)

namespace :ratings do
  desc "Migrate Old Notifications to new Schema"
  task :fromQuestions => :environment do
      puts "Starting to migrate"
	  questions = Question.where(:was_answered => true)
      questions.each do |question|
		  puts question.id
		  asker = question.asker
		  answerer = question.answerer
		  if !question.ask_rank.nil?
			  asker.rating = ((asker.rating*asker.completed_conversations) + question.ask_rank)/(asker.completed_conversations+1)
			  asker.completed_conversations = asker.completed_conversations + 1
			  asker.save
		  end
		  
		  if !question.rank.nil?
			  answerer.rating = ((answerer.rating*answerer.completed_conversations) + question.rank)/(answerer.completed_conversations+1)
			  answerer.completed_conversations = answerer.completed_conversations + 1
			  answerer.save
		  end 
      end
  end
end
