class MessagesController < ApplicationController
	def index
		@conversations = current_user.mailbox.conversations
	end
	
	def new 
		
	end
end
