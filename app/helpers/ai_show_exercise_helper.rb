module AiShowExerciseHelper
  def ai_show_exercise(user_message_content)
    if user_message_content.present?
      client = OpenAI::Client.new
      exercises = Exercise.all.map { |exercise| "#{exercise.name}"}
      response = client.search(
        engine: "babbage",
        parameters:  {
        documents: exercises,
        query: user_message_content,
        examples_context: "find the exercise that matches the exercise in the query",
        max_tokens: 20,
        stop: ['\n', '===', '---']
        }
      )
      ai_hash = JSON.parse response.to_s
      ai_hash["answers"]&.each do |answer|
        Message.create!({
        category: "receive",
        user: current_user,
        content: answer
        })
      end
    end
  end
end
