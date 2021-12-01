module AiHelpRewardHelper
    # rewards progress made by the user
  def ai_help_reward(user_message_content)
    if user_message_content.present?
     client = OpenAI::Client.new
    #  client.files.upload(parameters: { file: 'db/data.jsonl', purpose: 'search' })
     response = client.answers(parameters: {
       documents: ["The artificial inteligence coach is praising #{current_user.name} for successfully completing a hard workout."],
       question: user_message_content,
       model: "davinci",
       examples_context: "Congratulate #{current_user.name} for completing progress",
       examples: [
        # Generic
        ["Wow, that was intense.", "One step closer to your ideal body!"],
        ["I just finished my workout", "Good job!"],
        ["done, but todays workout was tough", "You made it through though!"],
        ["damn that was tough", "Take a break, you earned!"],
        ["done", "Good!"],
        ["I think I made a lot of progress today", "You sure did!"],
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
        Message.create!({
          category: "emoji",
          user: current_user,
          content: ["💪💪💪", nil].sample
        })
        end
      end
    end


end
