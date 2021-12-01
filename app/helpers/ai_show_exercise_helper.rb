module AiShowExerciseHelper

  def ai_show_exercise(user_message_content)
    if user_message_content.present?
      Message.create!({
        category: "receive",
        user: current_user,
        content: "Give me a moment."
      })
      identified_exercise = ai_classify_exercise(user_message_content)
      matching_name = ai_match_exercise(identified_exercise)
      ai_exercise_describe(user_message_content, matching_name)
    end
  end

  # used to identify the exercise in the query
  def ai_classify_exercise(user_message_content)
    client = OpenAI::Client.new
    response = client.classifications(parameters: {
      query: user_message_content,
      model: "curie",
      examples: [
        ["Tell me about bench presses?", "bench press"],
        ["Tell me how to do squats?", "squat"],
        ["How do I do a front lat pulldown?" , "front lat pulldown"],
        ["Could you show me some information on glute extensions?", "glute extension"],
        ["I want to know more about the incline bench", "incline bench"],
        ["What is a chin up?", "chin up"],
        ["How do you do this a hammer curl?", "hammer curl"],
        ["What is my history for deadlifts?", "dead lift"]
      ],
        temperature: 0.3,
      })
      exercise_identification = JSON.parse(response.to_s)['label']
  end


  def ai_match_exercise(identified_exercise)
    exercises = Exercise.all.map {|exercise| "#{exercise.name}"}
    client = OpenAI::Client.new
    response = client.search(engine:"ada",
      parameters: {
        documents: exercises,
        query: identified_exercise,
        examples_context: "find an exercise that is similar to #{identified_exercise}"
      }
    )
    results = JSON.parse(response.to_s)
    sorted_results = results['data'].sort_by {|hash| -hash['score'].to_i}
    if sorted_results.first["score"] > 600
      Exercise.find_by(name: exercises[sorted_results.first['document']])
    else
      Exercise.create(name: identified_exercise, station_id: Station.find_by(name:"empty").id)
    end
  end


  def ai_exercise_describe(user_message_content, exercise)
    client = OpenAI::Client.new
    #  client.files.upload(parameters: { file: 'db/data.jsonl', purpose: 'search' })
    response = client.answers(parameters: {
       documents: [exercise.name],
       question: user_message_content,
       model: "davinci",
       examples_context: "Teach user about exercises",
       examples: [
        ["How do I do a bench press?", "To do a bench press, lie on your back on a flat bench. Grip a barbell with hands slightly wider than shoulder-width. Press your feet firmly into the ground and keep your hips on the bench throughout the entire movement.Slowly lift bar off rack and lower the bar to the chest, allowing elbows to bend out to the side.Stop lowering when elbows are just below the bench. Perform 5-10 reps, depending on weight used"],
        ["How do I do a cable fly?", "Stand between two high pulley cables with stirrup attachments. Hold left handle in left hand and right handle in right hand with an overhand grip (palms facing down). Stand upright in a staggered stance with arms outstretched but slightly bent so that knuckles are facing forward.. This is the starting position. Begin exercise by pushing cables forward and together so that your wrists cross when arms are fully extended. Pause, then slowly reverse movement back to starting position. This completes one rep."],
        ["Could you tell me about how to do a dead lift?", "To do a deadlift, stand with your feet shoulder-width apart, grasp the bar with your hands just outside your legs. Lift the bar by driving your hips forwards, keeping a flat back. Lower the bar under control."],
        ["How do I do a chin up?", "To do a chin up, grab the bar with both hands, with your palms facing you, and arms shoulder-width apart. Pull yourself up until your chin is above the bar. Your elbows will be fully bent here. Pause for a second. With a controlled motion, lower yourself all the way back down, until your arms are straight."],
        ["What is an incline bench press?", "The incline bench press is a variation of the well known flat bench press. Like all variations of bench pressing the workout is done for strength training, gaining muscle mass, and for sports."],
        ["What is a rear delt fly?", "The rear delt fly, also known as the rear delt raise or the bent-over dumbbell reverse fly, is a weight training exercise that targets your upper back muscles and shoulder muscles, particularly the posterior deltoids, or rear deltoids, on the backside of your shoulders."]
      ],
       max_tokens: 70,
       stop: ['\n', '===', '---']
    })
    ai_hash = JSON.parse response.to_s
    ai_hash["answers"]&.each do |answer|
      # receive just a basic answer
      Message.create!({
        category: "receive",
        user: current_user,
        content: answer
      })
    end
  end
end
