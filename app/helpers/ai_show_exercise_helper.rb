module AiShowExerciseHelper
  def ai_show_exercise(user_message_content)
    if user_message_content.present?
      Message.create!({
        category: "receive",
        user: current_user,
        content: "Give me a moment."
      })
      identified_exercise = exercise_classifier(user_message_content).content
      matching_name = exercise_matcher(identified_exercise)
      Exercise.find_by(name: matching_name)
      Message.create!({
        category: "receive",
        user: current_user,
        content: retrieved_database_entry
      })

      # todo
    end
  end



  # used to identify the exercise in the query
  def exercise_classifier(user_message_content)
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
      # debugging only will remove
      Message.create!({
        category: "receive",
        user: current_user,
        content: exercise_identification
        })
  end


  def exercise_matcher(identified_exercise)
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
    raise
    if sorted_results.first["score"] > 600
      return returned_exercise = exercises[sorted_data.first['document']]
    else
      new_exercise = Exercise.create(name: exercise_name, station_id: Station.find_by(name:"empty").id)
      return new_exercise.name
    end

end
