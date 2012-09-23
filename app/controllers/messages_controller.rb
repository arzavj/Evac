class MessagesController < ApplicationController
	def index
		@conversations = current_user.mailbox.conversations
	end
	
	def create 
		if params[:message][:notified_object_id]
			current_user.send_message(User.find(params[:message][:notified_object_id]), params[:message][:body], params[:message][:subject])
		elsif params[:message][:conversation_id]
			current_user.reply_to_conversation(Conversation.find(params[:message][:conversation_id]), params[:message][:body])
		end
		redirect_to messages_url
	end

end
