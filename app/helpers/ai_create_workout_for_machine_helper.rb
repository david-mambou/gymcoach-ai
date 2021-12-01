module AiCreateWorkoutForMachineHelper
   # request AI to generate a new workout card based on user requests
   def ai_create_workout_for_machine(user_query)
    client = OpenAI::Client.new

    # sort documents by highest score
    exercises = Exercise.all.map { |exercise| "#{exercise.name}" }
    recommend_exercise = client.search(engine: "babbage", parameters: {
      documents: exercises,
      query: user_query,
      examples_context: "find the best exercise that will satisfy user goal : #{current_user.goal}",
    })
    reply = JSON.parse recommend_exercise.to_s
    sorted_data = reply['data'].sort_by { |hash| -hash['score'].to_i}
    exercise_name = exercises[sorted_data.first['document']]

    # get recommendation based on used goal
    reason = client.completions(engine: "curie", parameters: {
      prompt: "The fitness coach is very kind and professional, explaining to a beginner how this exercise will help the goal:\n\n
          User: will do bench press and their goal is to get in shape for a summer pool party.\n
          AI: This will work your rectus abdominis muscle, the most critical body part for a beach party.\n\n
          User: will do squat and their goal is to run faster.\n
          AI: It is important to keep lower legs balanced, this works all the major muscle groups, the gluteus maximus, hip flexors, and quadriceps.\n\n
          User: will do pullups and their goal is to get a v-taper.\n
          AI: Pullups target the latissimus dorsi muscles, giving you a nice v-taper that you want.\n\n
          User: will do bicep curls and their goal is to have larger biceps\n
          AI: This exercise will target both the long head and short head of the bicep, helping you get larger arms.\n\n
          User: will do #{exercise_name} and their goal is to #{current_user.goal}\n
          AI:",
      temperature: 0.6,
      max_tokens: 64,
      n: 1,
      frequency_penalty: 0,
      presence_penalty: -2,
      stop: ["\n"]
    })

    # create workout and store
    workout = Workout.new(
      name:  exercise_name,

      day: Date.today,
      user: current_user,
      pros_and_cons: reason["choices"][0]["text"],
      workout_template: WorkoutTemplate.all.sample
    )

    Message.create!({
      category: "card_workout",
      user: current_user,
      workout: workout
                    })
  end
end
