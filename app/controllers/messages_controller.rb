class MessagesController < ApplicationController
  def create
    set_existing_messages_as_read
    # send user message to AI
    user_submission = Message.new(message_params)
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

    redirect_to new_workout_path


    # 1) get users intent
    # ai_direct_queryparams[:message][:content]


    # todo: change this to ajax call to make responses immediate


        # exercise_recommendation = helpers.ai_find_exercise_for_muscle("lets workout my back")
    # muscles_used = helpers.ai_find_muscles_for_exercise("what does benchpress work on?")
    # exercise_recommendation = helpers.ai_find_exercise_for_muscle("I want to work on chest")
    # exercise_recommendation = helpers.ai_find_exercise_for_muscle("I want to work on my front delts")
    # exercise_recommendation = helpers.ai_find_exercise_for_muscle(" I want to work back today")
    # exercise_recommendation = helpers.ai_find_exercise_for_muscle("I want to work on chest. Can you suggest something that only uses dumbbells for today? I dont want to do dumbbell bench press")
    # exercise_recommendation = helpers.ai_find_exercise_for_muscle("I am thinking to use only dumbbells today for chest")
    # direct_user_query = helpers.ai_direct_query("this workout looks too easy")





    # message = Message.new(message_params)
    # authorize message
    # if message.save! && message.content != ""

                                      # todo: change this to a chat view.rb?

                                      # elect the AI method here: if it's not a workout creation, the chat should another AI method
                                      # helpers.ai_generic_reply(message.content)

      # helpers.ai_find_exercise_for_muscle(message.content)
      # redirect_to new_workout_path
    # end
  end

  private

  def message_params
    params.require(:message).permit(:category, :content, :workout_id, :workout_set_id, :message)
  end

  def set_existing_messages_as_read
      Message.where(read: false).update_all(read: true)
  end
end
