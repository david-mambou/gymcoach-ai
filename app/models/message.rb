class Message < ApplicationRecord
  # workout and workout set optional, only if message is card
  belongs_to :workout, optional: true
  belongs_to :workout_set, optional: true
  belongs_to :user
  enum category: [:submit, :receive, :card_workout, :card_chart, :emoji, :link], _default: "submit"

  # user will receive a message from the AI in the chat interface
  def self.receive(user, content)

    message = Message.new({
      user: user,
      category: "receive",
      content: content
    })

    message.save!
   end
end
