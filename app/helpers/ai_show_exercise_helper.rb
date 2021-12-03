module AiShowExerciseHelper

  def ai_show_exercise(user_message_content)
    if user_message_content.present?
      identified_exercise = ai_classify_exercise(user_message_content)
      matching_exercise = ai_match_exercise(identified_exercise)
      exercise_intent = ai_determine_intent_of_question(user_message_content)
      matching_exercise.update(description: ai_exercise_describe("What is #{matching_exercise.name}")) if matching_exercise.description == nil
      matching_exercise.update(instruction: ai_exercise_instruct("How do I do #{matching_exercise.name}")) if matching_exercise.instruction == nil
      case exercise_intent
      when "Exercise_how"
        convert_to_receive_message(matching_exercise.instruction)
      when "Exercise_what"
        convert_to_receive_message(matching_exercise.description)
      # when "Exercise_show"
      #   Message.create!({
      #     category: "link",
      #     user: current_user,
      #     content:  matching_exercise.id
      #   })
      end

    end
  end

  # used to identify the exercise in the query
  def ai_classify_exercise(user_message_content)
    client = OpenAI::Client.new
    response = client.answers(parameters: {
      documents: ["AI is analyzing the subject of the question"],
      model: "davinci",
      examples_context: "Identify exercise",
      question: user_message_content,
      examples: [
        ["Tell me about bench presses.", "bench press"],
        ["Tell me how to do squats.", "squat"],
        ["How do I do a front lat pulldown?", "front lat pulldown"],
        ["Could you show me some information on glute extensions?", "glute extension"],
        ["I want to know more about the incline bench", "incline bench"],
        ["What is a chin up?", "chin up"],
        ["How do you do this a hammer curl?", "hammer curl"],
        ["What is my history for deadlifts?", "dead lift"]
      ],
        temperature: 0.2,
        stop: ['\n', '===', '---']
      })
      JSON.parse(response.to_s)['answers'].first
      # raise
  end


  def ai_match_exercise(identified_exercise)
    exercises = Exercise.all.map {|exercise| "#{exercise.name}"}
    client = OpenAI::Client.new
    response = client.search(engine:"davinci",
      parameters: {
        documents: exercises,
        query: identified_exercise,
        examples_context: "find an exercise that is similar to #{identified_exercise}"
      }
    )
    results = JSON.parse(response.to_s)
    sorted_results = results['data'].sort_by {|hash| -hash['score'].to_i}
    if sorted_results.first["score"] > 250
      Exercise.find_by(name: exercises[sorted_results.first['document']])
    else
      # debugging, possibly take out before pitch
      Exercise.create(name: identified_exercise, station_id: Station.find_by(name:"empty").id)
    end
  end

  def ai_determine_intent_of_question(user_query)
    client = OpenAI::Client.new
    a = "exercise_how"
    b = "exercise_what"
    c = "exercise_show"
    response = client.classifications(parameters: {
      query: user_query,
      model: "curie",
      examples: [
        # CREATE A WORKOUT FOR MUSCLE
        ["How do I do a bench press?", a],
        ["What is a dive bomber pushup?", b],
        ["Tell me about a dumbbell snatch", b],
        ["Could you give me instructions on how to do a floor seated lat pull?", a],
        # ["Could you show me what you have on pull-ups?", c],
        # ["I want to look at what I did with squats.", c],
        # ["I want to see the dead lift page.", c],
        ["Could you tell me about goblet squats?", b],
        ["Could you tell me about the kettlebell snatch?", b],
        # ["Can you show some detailed information on burpees?", c ]
      ],
      temperature: 0.3,
    })
    JSON.parse(response.to_s)['label']
  end


  def ai_exercise_instruct(user_message_content)
    client = OpenAI::Client.new
    exercises = Exercise.all.map {|exercise| "#{exercise.name}"}
    #  client.files.upload(parameters: { file: 'db/data.jsonl', purpose: 'search' })
    response = client.answers(parameters: {
      documents: exercises,
      question: user_message_content,
      model: "davinci",
      examples_context: "Teach user about exercises",
      examples: [
        ["How do I do a bench press?", "To do a bench press, lie on your back on a flat bench. Grip a barbell with hands slightly wider than shoulder-width. Press your feet firmly into the ground and keep your hips on the bench throughout the entire movement.Slowly lift bar off rack and lower the bar to the chest, allowing elbows to bend out to the side.Stop lowering when elbows are just below the bench. Perform 5-10 reps, depending on weight used"],
        ["How do I do a cable fly?", "Stand between two high pulley cables with stirrup attachments. Hold left handle in left hand and right handle in right hand with an overhand grip (palms facing down). Stand upright in a staggered stance with arms outstretched but slightly bent so that knuckles are facing forward.. This is the starting position. Begin exercise by pushing cables forward and together so that your wrists cross when arms are fully extended. Pause, then slowly reverse movement back to starting position. This completes one rep."],
        ["Could you tell me about how to do a dead lift?", "To do a deadlift, stand with your feet shoulder-width apart, grasp the bar with your hands just outside your legs. Lift the bar by driving your hips forwards, keeping a flat back. Lower the bar under control."],
        ["How do I do a chin up?", "To do a chin up, grab the bar with both hands, with your palms facing you, and arms shoulder-width apart. Pull yourself up until your chin is above the bar. Your elbows will be fully bent here. Pause for a second. With a controlled motion, lower yourself all the way back down, until your arms are straight."],
      ],
      max_tokens: 70,
      stop: ['\n', '===', '---']
    })
    parsed_response = JSON.parse response.to_s
    parsed_response["answers"].first
  end



  def ai_exercise_describe(user_message_content)
    client = OpenAI::Client.new
    exercises = Exercise.all.map {|exercise| "#{exercise.name}"}
    #  client.files.upload(parameters: { file: 'db/data.jsonl', purpose: 'search' })
    response = client.answers(parameters: {
       documents: exercises,
       question: user_message_content,
       model: "davinci",
       examples_context: "Teach user about exercises",
       examples: [
        ["What is an incline bench press?", "The incline bench press is a variation of the well known flat bench press. Like all variations of bench pressing the workout is done for strength training, gaining muscle mass, and for sports."],
        ["What is a rear delt fly?", "The rear delt fly, also known as the rear delt raise or the bent-over dumbbell reverse fly, is a weight training exercise that targets your upper back muscles and shoulder muscles, particularly the posterior deltoids, or rear deltoids, on the backside of your shoulders."],
        ["What is the barbell benchpress?", "The barbell bench press requires the person working out to lie flat on a bench which allows for improved muscle stability and the ability to lift a heavy amount of weight. ... The barbell bench press exercise is a great for people looking to build strength, increase body size, and power."],
        ["What is a lateral raise?", "lateral raise is a strength training shoulder exercise characterized by lifting a pair of dumbbells away from your body in an external rotation. Lateral raises work the trapezius muscle in your upper back as well as the deltoid muscle group in your shoulders—particularly the anterior and lateral deltoids"]
      ],
       max_tokens: 90,
       stop: ['\n', '===', '---']
    })
    parsed_response = JSON.parse response.to_s
    parsed_response["answers"].first
  end


  def convert_to_receive_message(response)
    Message.create!({
        category: "exercise_info",
        user: current_user,
        content: response
    })
  end
end
