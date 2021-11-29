class MessagesController < ApplicationController

  # existing session, just show messages, wait for user action
  def index
    @messages = policy_scope(Message)
    @message = Message.new # so that we can use the input form anytime

    if params[:new_session]
      purgable_messages = current_user.messages
      purgable_messages.destroy_all

      # if Message.count == 0
      #   # first time user
      #   Message.receive(current_user, "Welcome! I will be your new coach, nice to meet you")
      # else
        # returning user
        Message.receive(current_user, "Welcome back #{current_user.name}! Today, we are scheduled for a #{ current_user.current_routine } routine. How do you feel about this?")
        next_workout = Workout.latest_workout_for_routine(current_user.current_routine)
        Message.create!({
          category: "card_workout",
          user: current_user,
          workout: next_workout
                        })
      # end
    end
  end

  # send user message to AI
  def create
    set_existing_messages_as_read
    # send user message to AI
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

  def set_existing_messages_as_read
      Message.where(read: false).update_all(read: true)
  end
end
