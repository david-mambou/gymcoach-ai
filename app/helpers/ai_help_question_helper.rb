module AiHelpQuestionHelper
  # answers users generic questions, force always to the workout
  def ai_help_question(user_message_content)
    if user_message_content.present?
     client = OpenAI::Client.new
     client.files.upload(parameters: { file: 'db/data.jsonl', purpose: 'search' })
     response = client.answers(parameters: {
       documents: ["I bench press 3 sets of 25kg at 8 reps on july 7th, 2020 and it was easy.", "I barbell squat 20kg twice, but failed on the third set on november 1st, 2021. But it was hard."],
       question: user_message_content,
       model: "davinci",
       examples_context: "This is a gym coach, very friendly, and will respond always to keep user in the gym to do their workout",
       examples: [

        # silly
        ["lol", "Whats so funny?"],

        # opinions
        ["just think this is cool", "Thanks. How about we workout?"],

        # short
        ["yes", "awesome."],

         # distractions
         ["Can we eat soon?", "Let's finish a workout first. "],

         # introductions
         ["hello", "hi #{current_user.name}, how you feeling today?"],

         # negative feelings
         ["not yet ready to workout..", "Don't worry. Most important thing is to show up in the gym. Let's do a quick workout then?"],
         ["no!", "It will be ok, let's workout quickly then."],

         # exhaustion
         ["im tired", "You can rest for a bit longer, would you like to continue the workout today?"],

         # workout related
         ["lets not do body weight exercises", "No problem. Let's try something else then."],

        ],
       max_tokens: 20,
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
end