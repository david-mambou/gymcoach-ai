module AiEditChangeExerciseHelper
   # request AI to generate a new workout card based on user requests
   def ai_edit_change_exercise(user_query)
    client = OpenAI::Client.new
    reason = client.completions(engine: "davinci", parameters: {
      prompt: "The fitness coach is very kind and professional, explaining what muscles an exercise uses for their goal truthfully:\n\n
          User: Someones taken the bench, can you recommend a rope exercise instead?\n\n
          AI: Shoot! Well, no problem. I thought of another exercise then. How about this?",
      temperature: 0.4,
      max_tokens: 64,
      n: 1,
      frequency_penalty: 0,
      presence_penalty: 1,
      stop: ["\n"]
    })

    # find a similar workout as current active workout
    active_workout = Workout.find_by(status: 'active')
    exercises = Exercise.all.map { |exercise| "#{exercise.name}" }
    
    recommend_exercise = client.search(engine: "davinci", parameters: {
      documents: exercises,
      query: user_query,
      examples_context: "find a different exercise that is not #{active_workout.exercises.last.name if active_workout.present?}",
    })

    reply = JSON.parse recommend_exercise.to_s
    sorted_data = reply['data'].sort_by { |hash| -hash['score'].to_i}
    exercise_name = exercises[sorted_data.first['document']]

    # find latest set for exercise to populate new sets and reps
    existing_exercise = Exercise.find_by(name: exercise_name)
    latest_set1 = existing_exercise.workout_sets[-1]
    latest_set2 = existing_exercise.workout_sets[-2]

    # create workout and store workout sets
    workout = Workout.new(
      name:  exercise_name,
      day: Date.today,
      user: current_user,
      pros_and_cons: "How about doing this workout instead then?",
      workout_template: WorkoutTemplate.all.sample
    )
    workout.workout_sets << latest_set1
    workout.workout_sets << latest_set2

    if active_workout.present?
     active_workout.status = 'cancelled' 
     active_workout.save
    end

    # create workout card for the user
    Message.create!({
      category: "card_workout",
      user: current_user,
      workout: workout
                    })
  end
end