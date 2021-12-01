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
    reason = client.completions(engine: "davinci", parameters: {
      prompt: "The fitness coach is very kind and professional, explaining what muscles an exercise uses for their goal:\n\n
          User: will do bench press and their goal is to get a bigger chest.\n
          AI: This will work the pectoralis major and pectoralis minor muscles intensly, perfect for your goal for a bigger chest.\n\n
          User: will do bench press and their goal is to get in shape for a summer pool party.\n
          AI: This will work your rectus abdominis muscle, the most critical body part for a beach party. \n\n
          User: will do squat and their goal is to run faster.\n
          AI: It is important to keep lower legs balanced, this works all the major muscle groups, the gluteus maximus, hip flexors, and quadriceps.\n\n
          User: will do pullups and their goal is to get a v-taper.\n
          AI: Pullups target the latissimus dorsi muscles, perfect for keeping your body well rounded.\n\n
          User: will do bicep curls and their goal is to have larger biceps\n
          AI: This exercise will target both the long head and short head of the bicep, helping you get larger arms.\n\n
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
