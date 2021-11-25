module AiHelper
  # determine the users intention based on their message

  # request AI to generate a generic reply based on user input
  def ai_generic_reply(user_message_content)
    # double check that the message is not empty
    if user_message_content.present?
     client = OpenAI::Client.new
     client.files.upload(parameters: { file: 'db/data.jsonl', purpose: 'search' })
     response = client.answers(parameters: {
       documents: ["I bench press 3 sets of 25kg at 8 reps on july 7th, 2020 and it was easy.", "I barbell squat 20kg twice, but failed on the third set on november 1st, 2021. But it was hard."],
       question: user_message_content,
       model: "davinci",
       examples_context: "In 2017, U.S. life expectancy was 78.6 years.",
       examples: [["What is human life expectancy in the United States?","78 years."]],
       max_rerank: 10,
       max_tokens: 5
     })

     ai_hash = JSON.parse response.to_s
      ai_hash["answers"].each do |answer|
        # receive just a basic answer
        Message.create!({
          category: "receive",
          content: answer
        })
      end
    end
  end

  # request AI to generate a new workout card based on user requests
  def ai_new_workout(user_message_content)
    # double check that the message is not empty
    if user_message_content.present?
     client = OpenAI::Client.new
     client.files.upload(parameters: { file: 'db/data.jsonl', purpose: 'search' })
     response = client.answers(parameters: {
       documents: ["I bench press 3 sets of 25kg at 8 reps on july 7th, 2020 and it was easy.", "I barbell squat 20kg twice, but failed on the third set on november 1st, 2021. But it was hard."],
       question: user_message_content,
       model: "davinci",
       examples_context: "In 2017, U.S. life expectancy was 78.6 years.",
       examples: [["What is human life expectancy in the United States?","78 years."]],
       max_rerank: 10,
       max_tokens: 5
     })

     ai_hash = JSON.parse response.to_s
      ai_hash["answers"].each do |answer|
        # receive just a basic answer
        Message.create!({
          category: "card_workout",
          workout: Workout.first
        })
      end
    end
  end

  # request AI to get top X exercises based on user needs
  def ai_top_exercises
     # double check that the message is not empty
     if true
      arr = []
      exercises = Exercise.all.select([:id, :name])

      exercises.each do |exercise|
        arr << "the #{exercise.name} exercise works on muscle groups #{exercise.muscle_list}"
      end

      client = OpenAI::Client.new
      response = client.answers(parameters: {
        documents: arr,
        question: "What are some good exercises to work on the back?",
        model: "davinci", #babbage
        examples_context: "Bench press and pushups are good for the upper body. Lunges and squats are great for the legs.",
        examples: [
          ["What are the 2 top upper body exercises?", "bench press, pushups"],
          ["What are some good leg exercises?", "lunges, squats"]
        ],
        max_tokens: 20
      })

      reply = JSON.parse response.to_s
      reply = reply["answers"]
      raise
      return reply
     end
   end
end
