module AiHelpQuestionHelper
  # answers users generic questions, force always to the workout
  def ai_help_question(user_message_content)
    if user_message_content.present?
     client = OpenAI::Client.new
    #  client.files.upload(parameters: { file: 'db/data.jsonl', purpose: 'search' })
     response = client.answers(parameters: {
       documents: ["It is #{Time.zone.today.strftime('%A, %B%e, %l:%M')} and the artificial inteligence coach is answering coach is answering questions from #{current_user.name}. The coach is friendly and respond to questions."],
       question: user_message_content,
       model: "davinci",
       examples_context: "This is a artificial intelligence gym coach, very friendly, and will respond to most questions.",
       examples: [

        # General question of identity
        ["Who are you?", "I am an artificial intelligence, designed to help you get in shape, #{current_user.name}. How can I help you?"],
        ["Who created you?", "I was created by the OpenAI Company and employed by Team Gymcoach AI."],

        # Date
        ["What day is it today?", "It is #{Time.zone.today.strftime('%A, %B%e')}"],
        ["What time is it today?", "It is time to get in shape."],

        # Presentation
        ["Could you tell me about yourself?", "I am an artificial intelligence coach, just for you."],
        ["What do you do exactly?", "I can generate workouts tailormade for your personal needs"],
        ["What else can you do?", "I can keep track of your records and visualize them to help you see your progress."],
        ["How do I use you?", "Just tell me how you want to improve your body."],

        # General help, vague
        ["Can you help me?", "Sure, please tell me what you need."],
        ["Why?", "Please be more specific."],

         # distractions/redirecting questions back to workout
         ["Can we eat soon?", "Let's finish a workout first."],
         ["Could you tell me what I should do with my life?", "I think you should use me to get in shape."],
         ["Should I become a programmer?", "I think you should get in shape first, #{current_user.name}."],
        ],
       max_tokens: 23,
       stop: ['\n', '===', '---']
     })
     raise
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
