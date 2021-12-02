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
    @message = Message.new(message_params)
    @message.user = @user
    authorize @message
    # prevent user from sending blank messages
    if @message.content.present?
      if @message.save!
        helpers.ai_direct_query(@message.content)
        respond_to do |format|
          format.html # Follow regular flow of Rails
          format.js
        end
        # determine user intent and respond with AI
      else
        respond_to do |format|
          format.html { render 'messages/index' } # Follow regular flow of Rails
          format.js { render 'messages/index' }
        end
      end
    end

    # redirect_to messages_path
  end

  private

  def message_params
    params.require(:message).permit(:category, :content, :workout_id, :workout_set_id, :message, :user_id)
  end

  def set_existing_messages_as_read
    Message.where(read: false).update_all(read: true)
  end
end
