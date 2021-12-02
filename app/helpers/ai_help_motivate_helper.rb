module AiHelpMotivateHelper
    # encourages the user to keep working out or tells the user to try again another day
  def ai_help_motivate(user_message_content)
    if user_message_content.present?
     client = OpenAI::Client.new
    #  client.files.upload(parameters: { file: 'db/data.jsonl', purpose: 'search' })
     response = client.answers(parameters: {
       documents: ["#{current_user.name} is feeling down and needs emotional support."],
       question: user_message_content,
       model: "davinci",
       examples_context: "Cheer #{current_user.name} up and encourage them.",
       examples: [

        # Not related to workouts
        ["I dont have much energy for today", "That's okay, there's always tomorrow."],
        ["I drank alot last night", "You should relax for today. Might I suggest working out tomorrow instead?"],
        ["just broke up with girlfriend, not feeling like doing a workout", "Love may betray you, but muscles won't."],
        ["very busy today, hard to concentrate", "Maybe later in the week would be better"],

        # Lack of progress
        ["I'm not making any progress", "#{current_user.name}, you are making progress! It takes patience to become stronger! Hang in there!"],
        ["I'm tired.", "Maybe I can suggest a different menu. What do you want to do?"]

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
