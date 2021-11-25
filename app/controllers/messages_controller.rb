class MessagesController < ApplicationController
  # create message to send to AI
  def create
    # by default, category will be a message to the AI
    message = Message.new(message_params)
    authorize message
    if message.save! && message.content != ""

      # todo: change this to a chat view.rb?

      # elect the AI method here: if it's not a workout creation, the chat should another AI method
      # helpers.ai_generic_reply(message.content)

      helpers.ai_find_exercise_for_muscle(message.content)
      redirect_to new_workout_path
    end
  end

  private

  def message_params
    params.require(:message).permit(:category, :content, :workout_id, :workout_set_id, :message)
  end


end
