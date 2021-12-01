module AiHelpQuestionHelper
  # answers users generic questions, force always to the workout
  def ai_help_question(user_message_content)
    if user_message_content.present?
     client = OpenAI::Client.new
    #  client.files.upload(parameters: { file: 'db/data.jsonl', purpose: 'search' })
     response = client.answers(parameters: {
       documents: ["I bench press 3 sets of 25kg at 8 reps on july 7th, 2020 and it was easy.", "I barbell squat 20kg twice, but failed on the third set on november 1st, 2021. But it was hard."],
       question: user_message_content,
       model: "davinci",
       examples_context: "This is a gym coach, very friendly, and will respond always to keep user in the gym to do their workout",
       examples: [

        # General question of identity
        ["Who are you?", "I am an artificial intelligence, designed to help you get in shape, #{current_user.name}."],

        # Date
        ["What day is it today?", "It is #{Time.zone.today.strftime('%A, %B%e')}"],

        # Presentation
        ["Could you tell me about yourself?", "I am an artificial intelligence coach, just for you."],
        ["Can you tell me what else you can do?", "I can generate workouts tailormade for your personal needs and give you emotional support"],
        ["What else can you do?", "I can keep track of your records and visualize them to help you see your progress."],

         # distractions/redirecting questions back to workout
         ["Can we eat soon?", "Let's finish a workout first."],
         ["Could you tell me what I should do with my life?", "I think you should use me to get in shape."],
         ["Should I become a programmer?", "I think you should get in shape first"]
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
