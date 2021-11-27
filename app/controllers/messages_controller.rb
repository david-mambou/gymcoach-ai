class MessagesController < ApplicationController

  def index
    @messages = policy_scope(Message)
    @message = Message.new

    # AI Kick off user query with a generic message if start of chat
    if Message.count == 0 
      Message.create!({
        user: current_user,
        category: "receive",
        content: "Hi, I will be your personal coach today. What would you like to do today?"
      })
    end
  end

  # send user message to AI
  def create
    @user = current_user
    user_submission = Message.new(message_params)
    user_submission.user = @user
    authorize user_submission

    # check if user message is valid
    if user_submission.save!
      # determine user intent and process with AI
      intent = helpers.ai_direct_query(user_submission.content)

      case intent
      when 'create_workout'
        helpers.ai_create_workout(user_submission.content)
      when 'general_answer'
        helpers.ai_general_answer(user_submission.content)
      else
        helpers.ai_general_answer(user_submission.content)
      end
    end

    redirect_to messages_path

  end

  private
  
  def message_params
    params.require(:message).permit(:category, :content, :workout_id, :workout_set_id, :message, :user_id)
  end
end
