module AiHelpMotivateHelper
    # answers users generic questions, force always to the workout
  def ai_help_motivate(user_message_content)
    if user_message_content.present?
     client = OpenAI::Client.new
    #  client.files.upload(parameters: { file: 'db/data.jsonl', purpose: 'search' })
     response = client.answers(parameters: {
       documents: ["The artificial inteligence coach is praising #{current_user.name} for successfully completing a hard workout."],
       question: user_message_content,
       model: "davinci",
       examples_context: "Congratulate #{current_user.name} for completing progress",
       examples: [

        ["I just finished my workout", g],
        ["done, but todays workout was tough", g],
        ["I struggled alot but was able to finish", g],
        ["that last set was really hard", g],
        ["damn that was tough", g],
        ["finished my workout", g],
        ["just finished", g],
        ["just finished!", g],


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
