class MessagesController < ApplicationController
  # create message to send to AI
  def create
    # by default, category will be a message to the AI
    message = Message.new(message_params)
    authorize message
    message.save!
    redirect_to new_workout_path
  end

  private

  def message_params
    params.require(:message).permit(:category, :content, :workout_id, :workout_set_id, :message)
  end
end
