module AiWelcomeUserHelper
  # request AI to generate a new workout card based on user requests
  def ai_welcome_user
    client = OpenAI::Client.new

    # welcome user
    reason = client.completions(engine: "davinci", parameters: {
      prompt: "A fitness coach is welcoming #{current_user.name} and asking them how they are doing, and if they are on track to achieve their goal #{current_user.goal}:\n\n
      AI: Hi! Welcome back #{current_user.name}!　How are you feeling today? \n\n
      AI: Welcome #{current_user.name}!　What would you like to work on today? \n\n
      AI: Welcome #{current_user.name}!　How about we do a workout today? I want to help you achieve your goal to #{current_user.goal} \n\n
      AI: Hi #{current_user.name}, how about we do a workout today? Lets achieve your goal to #{current_user.goal} \n\n
      AI: Hi #{current_user.name}, I am here to help you achieve your goal to Increase chest size \n\n
      AI:",
      temperature: 0.6,
      max_tokens: 64,
      n: 1,
      stop: ["\n\n"]
    })

    Message.create!({
      category: "receive",
      user: current_user,
      content: reason["choices"][0]["text"]
      })
  end
end