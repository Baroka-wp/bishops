class ConversationsController < ApplicationController
  def index
     @conversations = Conversation.all
   end

   def create
     if user_signed_in?
       @conversation = if Conversation.between(params[:sender_id], params[:recipient_id]).present?
                         Conversation.between(params[:sender_id], params[:recipient_id]).first
                       else
                         Conversation.create!(conversation_params)
                       end
       redirect_to conversation_messages_path(@conversation)
     else
       redirect_to root_path
     end
   end

   private

   def conversation_params
     params.permit(:sender_id, :recipient_id)
   end
end
