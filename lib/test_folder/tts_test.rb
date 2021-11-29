require 'tts'
def say(word)
s = "#{word}"
repeatTimes = 1
s.play("en", repeatTimes)
puts
puts "Successfully Said: #{word}"
end

# run = "yes"
# while  run == "yes"
# puts
# puts "What would you like to say?:"
# say(gets.to_s)
# puts
# puts "Would you like to say something else?"
# puts "yes / no"
# run = gets.chomp
# end
# puts
# say("Bye")
# puts "Bye"

"Bye".play
