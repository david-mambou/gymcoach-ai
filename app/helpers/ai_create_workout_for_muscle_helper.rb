module AiCreateWorkoutForMuscleHelper
   # request AI to generate a new workout card based on user requests
   def ai_create_workout_for_muscle(user_query)


    # exercises = ['glute bridge','lying hip abduction','barbell hip thrust','rope cable crunch','wood chops','planks','lying leg curl','sumo deadlift','standard deadlift','romanian deadlift','sumo squat','deadlift rack pull','dumbbell lunges','leg extensions (single leg)','leg extensions (both legs)','standard barbell squat','ass to grass squats','front squat','bulgarian barbell squat','sumo squat','goblin squats','lateral side step squats','jump squats','sitting calf raise','standing calf raise','smith machine barbell row','weighted pullups','standard pullups','hammergrip pullups','chinups','wide grip pullups','pulldown machine - narrow grip attachment','pulldown machine - single bar','pulldown machine - dual static position','row machine- underhand grip','row machine - overhand grip','row machine - hammer grip','Rope machine lat pullover','dumbbell single arm row','dumbbell supinated bicep curls','alternating dumbbell hammerhead curls','incline bench dumbbell curls','EZ bar standing bicep curl','preacher curl machine','spider curl','barbell bentover curl','dumbbell wrist curls','chest fly machine','chest press machine','smith machine bench press','weighted dips','chest fly machine straight arm','standard rope chest flies','Rope machine kneeling chest abductions','rope bench press (long handles)','barbell bench press','barbell incline bench','incline dumbbell bench press','standard pushups','archer pushups','diamond pushups','dumbbell lateral raises','hanging dumbbell lateral raises','side-lying bench lateral raise','single arm dumbbell lateral raise','shoulder shrugs','dumbbell reverse fly','dumbbell front raises','dumbbell shoulder military press','handstand pushups','wide pushups','straight bar pushdown','tricep dumbbell kickbacks','EZ bar skull crusher','close grip bench']

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
    Message.create!({
      category: "card_workout",
      user: current_user,
      workout: workout
                    })
  end

  def ai_find_exercise_for_muscle(user_query)
    arr = []
    exercises = ['glute bridge','lying hip abduction','barbell hip thrust','rope cable crunch','wood chops','planks','lying leg curl','sumo deadlift','standard deadlift','romanian deadlift','sumo squat','deadlift rack pull','dumbbell lunges','leg extensions (single leg)','leg extensions (both legs)','standard barbell squat','ass to grass squats','front squat','bulgarian barbell squat','sumo squat','goblin squats','lateral side step squats','jump squats','sitting calf raise','standing calf raise','smith machine barbell row','weighted pullups','standard pullups','hammergrip pullups','chinups','wide grip pullups','pulldown machine - narrow grip attachment','pulldown machine - single bar','pulldown machine - dual static position','row machine- underhand grip','row machine - overhand grip','row machine - hammer grip','Rope machine lat pullover','dumbbell single arm row','dumbbell supinated bicep curls','alternating dumbbell hammerhead curls','incline bench dumbbell curls','EZ bar standing bicep curl','preacher curl machine','spider curl','barbell bentover curl','dumbbell wrist curls','chest fly machine','chest press machine','smith machine bench press','weighted dips','chest fly machine straight arm','standard rope chest flies','Rope machine kneeling chest abductions','rope bench press (long handles)','barbell bench press','barbell incline bench','incline dumbbell bench press','standard pushups','archer pushups','diamond pushups','dumbbell lateral raises','hanging dumbbell lateral raises','side-lying bench lateral raise','single arm dumbbell lateral raise','shoulder shrugs','dumbbell reverse fly','dumbbell front raises','dumbbell shoulder military press','handstand pushups','wide pushups','straight bar pushdown','tricep dumbbell kickbacks','EZ bar skull crusher','close grip bench']

    client = OpenAI::Client.new
    response = client.answers(parameters: {
      documents: exercises,
      question: user_query,
      model: "davinci", #babbage
      examples_context: "find only 3 best exercises for the user to perform for their workout",
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
    workout = Workout.new(name: 'Workout 1',
                          day: Date.today,
                          user: current_user,
                          status: 'active')
    # each answer is an exercise name
    reply&.split(', ').each_with_index do |exercise_name, index|
      exercise = Exercise.find_by(name: exercise_name) # to improve
      3.times do
        WorkoutSet.create(nb_of_reps: 5,
                                      order_index: index,
                                      exercise: exercise,
                                      workout: workout,
                                      weight: 20)
      end
    end
    workout.save
    Message.create!({
      category: "card_workout",
      workout: workout
                    })
  end
end