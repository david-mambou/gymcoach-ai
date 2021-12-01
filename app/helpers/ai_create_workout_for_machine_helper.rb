module AiCreateWorkoutForMachineHelper
   # request AI to generate a new workout card based on user requests
  def ai_create_workout_for_machine(user_query)
    client = OpenAI::Client.new

    # sort documents by highest score
    exercises = Exercise.all.map { |exercise| "#{exercise.name}" }
    recommend_exercise = client.search(engine: "davinci", parameters: {
      documents: exercises,
      query: user_query,
      examples_context: "find an exercise for the muscle group in body with the machine requested",
    })
    reply = JSON.parse recommend_exercise.to_s
    sorted_data = reply['data'].sort_by { |hash| -hash['score'].to_i}
    exercise_name = exercises[sorted_data.first['document']]

    # get recommendation based on used goal
    reason = client.completions(engine: "davinci", parameters: {
      prompt: "The fitness coach is very kind and professional, explaining what muscles an exercise uses for their goal:\n\n
          User: please do chest with dumbbells.\n
          AI: Sure, how about this chest workout? It uses dumbbells.\n\n
          User: do a squat.\n
          AI: Sure, how about this barbell squat? You will need access to a barbell.\n\n
          User: lets do lateral raises.\n
          AI: This is perfect for a great shoulder exercise. You will just need to use dumbbells for this one.\n\n
          User: will do #{exercise_name} and their goal is to #{current_user.goal}\n
          AI:",
      temperature: 0.6,
      max_tokens: 64,
      n: 1,
      frequency_penalty: 0,
      presence_penalty: 1,
      stop: ["\n"]
    })

    fluff_ending = client.completions(engine: "curie", parameters: {
      prompt: "The fitness coach is very motivational, motivating user to do the workout:\n\n
          AI: I chose an intensity based on how you did on your previous workout. I think you can do this!\n
          AI: I think we will be able to do this exercise today, the difficulty is based on your past performance for this exercise.\n
          AI: You did a good job last time you did this exercise, lets try to beat it!\n
          AI: You did great last time, good luck for this one!\n
          AI:",
      temperature: 0.2,
      max_tokens: 34,
      n: 1,
      frequency_penalty: 0,
      presence_penalty: 1,
      stop: ["\n"]
    })

    # find latest set for exercise to populate new sets and reps
    existing_exercise = Exercise.find_by(name: exercise_name)
    latest_set1 = existing_exercise.workout_sets[-1].dup
    latest_set2 = existing_exercise.workout_sets[-2].dup

    # create workout and store workout sets
    workout = Workout.new(
      name:  exercise_name,
      day: Date.today,
      user: current_user,
      pros_and_cons: "#{reason["choices"][0]["text"]} \n\n#{fluff_ending["choices"][0]["text"]}",
      workout_template: WorkoutTemplate.all.sample
    )
    workout.workout_sets << latest_set1
    workout.workout_sets << latest_set2

    # create workout card for the user
    Message.create!({
      category: "card_workout",
      user: current_user,
      workout: workout
                    })
  end
end
