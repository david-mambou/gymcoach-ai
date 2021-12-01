class MessagesController < ApplicationController

  # existing session, just show messages, wait for user action
  def index
    if params[:new_session]
      purgable_messages = current_user.messages
      purgable_messages.destroy_all
      helpers.ai_welcome_user
    end
    @messages = policy_scope(Message).order(:created_at)
    @message = Message.new # so that we can use the input form anytime
  end

  # send user message to AI
  def create
    set_existing_messages_as_read
    @user = current_user
    user_submission = Message.new(message_params)
    user_submission.user = @user
    authorize user_submission

    # prevent user from sending blank messages
    if user_submission.content.present?
      if user_submission.save!
        # determine user intent and respond with AI
        helpers.ai_direct_query(user_submission.content)
      end
    end

    redirect_to messages_path
  end

  private

  def message_params
    params.require(:message).permit(:category, :content, :workout_id, :workout_set_id, :message, :user_id)
  end

  def set_existing_messages_as_read
      Message.where(read: false).update_all(read: true)
  end
end
