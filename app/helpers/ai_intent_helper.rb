# determine the users intention based on their message and call appropriate method
module AiIntentHelper
  def ai_direct_query(user_query)
    client = OpenAI::Client.new
    a = "create_workout_for_muscle"
    b = "create_workout_for_machine"
    c = "create_workout_for_routine"
    d = "edit_change_exercise"
    e = "show_exercise"
    f = "help_motivate"
    g = "help_reward"
    h = "help_question"

    response = client.classifications(parameters: {
      query: user_query,
      model: "curie",
      examples: [
        # CREATE A WORKOUT FOR MUSCLE
        ["Give me a good chest exercise", a],
        ["Give me a good chest exercise", a],
        ["I want to work my shoulders", a],
        ["I want to work my abs", a],
        ["What's good for improving my legs", a],
        ["I want to work on my six pack", a],
        ["my legs are sore, can you give me a chest workout?", a],
        ["I want train my legs today", a],
        ["I want to get rid of this beer belly", a],
        ["looking to workout my traps, any recommendations?", a],
        ["I want to get in shape for the summer", a],
        ["can you give a chest workout", a],
        ["can you give me a chest exercise", a],
        ["lets do bench", a],
        ["lets work back", a],
        
        # CREATE A WORKOUT FOR MACHINE
        ["I want to use dumbbells", b],
        [" want to use the rope machine", b],
        ["I want to use the bench for my workout today", b],
        ["bench today please", b],
        ["i want to record my runs", b],
        ["i want to do bench press", b],
        ["can i do lat pulldown?", b],
        
        # CREATE A WORKOUT FOR ROUTINE
        ["let's workout", c],
        ["what is my plan for today?", c],
        ["what was i supposed t odo", c],
                
        # EDIT CHANGE EXERCISE
        ["Someone has taken the bench, can you recommend a rope exercise instead?", d],
        ["Can you change my benchpress for another exercise?", d],
        ["The fly machine is being used, can you change my exercise?", d],
        ["i want to do another exercise", d],
        ["change my shoulder exercise", d],

        # SHOW EXERCISE
        ["how can I do squats?", e],
        ["I dont know how to do bench press", e],
        ["what is my history for squats?", e],
        ["what was my seat level on this exercise from before?", e],
        ["tell me how to do squats", e],


        # HELP MOTIVATE
        ["I dont have much energy for today", f],
        ["I drank alot last night", f],
        ["just broke up with girlfriend, not feeling like doing a workout", f],
        ["very busy today, hard to concentrate", f],

         # HELP REWARD
        ["I just finished my workout", g],
        ["done, but todays workout was tough", g],
        ["I struggled alot but was able to finish", g],
        ["that last set was really hard", g],
        ["damn that was tough", g],
        ["finished my workout", g],
        ["just finished", g],
        ["just finished!", g],
        
        # HELP QUESTIONS
        ["Hey what time is it?", h],
        ["who created this?", h],
        ["can you help me?", h],
        ["What is your name?", h]
      ],
      temperature: 0.3,
    })

    intent = JSON.parse(response.to_s)['label']

    # todo: debugging only, will remove
    Message.create!({
      category: "receive",
      user: current_user,
      content: intent
      })
    case intent

    when "Create_workout_for_muscle"
      ai_create_workout_for_muscle(user_query)
    when "Create_workout_for_machine"
      ai_create_workout_for_muscle(user_query)
    when "Create_workout_for_routine"
      ai_create_workout_for_routine(user_query)
    when "Edit_change_exercise"
      ai_edit_change_exercise(user_query)
    when "Show_exercise"
      ai_show_exercise(user_query)
    when "Help_motivate"
      ai_help_motivate(user_query)
    when "Help_reward"
      ai_help_reward(user_query)
    when "Help_question"
      raise
      ai_help_question(user_query)
    else
      ai_help_question(user_query)
    end
  end
end