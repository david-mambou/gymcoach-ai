class MessagesController < ApplicationController

  # existing session, just show messages, wait for user action
  def index
    @messages = policy_scope(Message)
    @message = Message.new # so that we can use the input form anytime

    if params[:new_session]
      if Message.count == 0 
        # first time user
        Message.receive(current_user, "Welcome! I will be your new coach, nice to meet you")
      else
        # returning user
        Message.receive(current_user, "Welcome back #{current_user.name}! Ready to start your workout?")
        # helpers.next_workout(current_user)
      end
    end
  end

  # send user message to AI
  def create
    @user = current_user
    user_submission = Message.new(message_params)
    user_submission.user = @user
    authorize user_submission

    if user_submission.save!
      # determine user intent and respond with AI
      helpers.ai_direct_query(user_submission.content)
    end

    redirect_to messages_path
  end

  private

  def message_params
    params.require(:message).permit(:category, :content, :workout_id, :workout_set_id, :message, :user_id)
  end
end
