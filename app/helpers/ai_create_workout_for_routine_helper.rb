module AiCreateWorkoutForRoutineHelper
  # request AI to generate a new workout card based on user requests
  def ai_create_workout_for_routine(user_query)
    client = OpenAI::Client.new
    response = client.answers(parameters: {
      documents: Exercise.all.pluck(:name),
      question: user_query,
      model: "davinci",
      examples_context: "find the 3 best exercises for the user to perform for their workout",
      examples: [
        ["I want to work my abs", "ab roller, rope crunches, leg lifts"],
        ["What should I do for a bigger chest?", "bench press, cable flies, fly machine"],
        ["What muscles are used in deadlift?", "hamstrings,glutes,erector spinae"],
        ["I dont want to do dumbbell bench press.", "dumbbell flys,rope chest abduction,chest press machine"],
        ["I want to work on chest. Can you suggest something that only uses dumbbells for today? I dont want to do dumbbell incline bench press", "dumbbell bench press, dumbbell flys, dumbbell supinated bench press"]
      ],
      max_tokens: 25,
      temperature: 0,
      stop: ['\n', '===', '---']
    })

    reply = JSON.parse response.to_s
    reply = reply["answers"]&.first

    workout = Workout.new(name: 'Workout Recommendation',
      day: Date.today,
      user: current_user,
      workout_template: WorkoutTemplate.all.sample
    )

    # each answer is an exercise name
    reply&.split(',').take(3).each_with_index do |exercise_name, index|
      # get existing exercise, else create new
      exercise = Exercise.find_by(name: exercise_name)
      if exercise.nil?
        exercise = Exercise.new(name: exercise_name)
        exercise.station = Station.all.sample
      end
      exercise.save!
      workout.save!

      3.times do
        WorkoutSet.create!(nb_of_reps: rand(5..12),
                            order_index: index,
                            exercise: exercise,
                            workout: workout,
                            weight: rand(5..20)
                          )
      end
    end

    # create workout card for user now
    Message.create!({
      category: "card_workout",
      user: current_user,
      workout: workout
                    })
  end
end