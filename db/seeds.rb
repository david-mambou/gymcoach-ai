# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# static arrays
# MUSCLES = ['hamstrings', 'glutes', 'quads', 'calves', 'biceps', 'triceps', 'forearms', 'shoulders', 'traps', 'abs'].freeze

# STATION_NAMES = ["captains chair", "back extension machine", "incline ab bench", "ab wheel", "seated ab machine", "bench rope machine", "rack", "open space", "leg extension machine", "lying leg curl machine", "sitting calf raise machine", "pulldown machine", "pullups bar", "dumbbells", "barbell", "fly machine", "decline bench machine", "assisted rack", "preacher curl"].freeze
# EXERCISES = ['wood-chops', 'planks', 'pushups', 'lunge', 'sit-ups', 'leg-raises', 'chinups', 'pullups', 'dips'].freeze


p "clearing database.."
Workout.destroy_all
WorkoutSet.destroy_all
Exercise.destroy_all
Station.destroy_all
p "database cleared.."

require "open-uri"
require "csv"

csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
station_filepath = "lib/csv_folder_for_presentation_seeds/simplified_station.csv"
exercise_filepath = "lib/csv_folder_for_presentation_seeds/simplified_exercise.csv"


# def strip_from_exercise_name(exercise_name)
#   exercise_name.sub(/\s(\(.*)\)/, '').sub(/\s-\s.+/,'')
# end

p "making station seeds"
CSV.foreach(station_filepath, csv_options).each do |row|
  Station.create!(name: row["Name"], base_incremental_weight: row["Base incremental weight"])
end

Station.find_by(name: "assisted rack")


p "making exercise seeds"
n = 0
CSV.foreach(exercise_filepath, csv_options).each do |row|
  new_exercise = Exercise.create!(name: row["Name"], muscle_list: row["Muscle group"], station: Station.find_by(name: row["Station"]))
  file = URI.open("#{row["Photos"]}")
  new_exercise.photo.attach(io: file, filename: 'filler.png', content_type: 'image/png')
  p "finishing exercise seed no. #{n+1}"
end

p "creating user"
team = User.create!(name: "team", email: "test@email.com", password: "123456", age: 25)

p "creating template workouts"
template_1 = Workout.create!(name: "Hypertrophy Pyramid Routine", user: team, template: true, pros: "improves muscle size", cons: "intense", date: Day.now)
WorkoutSet.create!(name: "warmup", exercise: Exercise.find_or_create_by(name: "Bench Press"), workout: template_1, nb_of_reps: 30, order_index: 1, weight: )
WorkoutSet.create!(name: "feeder", exercise: Exercise.find_or_create_by(name: "Bench Press"), workout: template_1, nb_of_reps: 12, order_index: 2, weight: )
WorkoutSet.create!(name: "feeder", exercise: , workout: template_1, nb_of_reps: 10, order_index: 3, weight: )
WorkoutSet.create!(name: "working", exercise: , workout: template_1, nb_of_reps: 8, order_index: 4, weight: )
WorkoutSet.create!(name: "cooldown", exercise: , workout: template_1, nb_of_reps: 15, order_index: 5, weight: )




template_2 = Workout.create!(name: "3/7 Routine", template: true, user: team, pros: "saves time", cons: "hard to change weights, intense", date: Day.now)
WorkoutSet.create!(name: "3 reps", exercise: , workout: template_2, nb_of_reps: 3, order_index: 1, weight: )
WorkoutSet.create!(name: "4 reps", exercise: , workout: template_12 nb_of_reps: 4, order_index: 2, weight: )
WorkoutSet.create!(name: "5 reps", exercise: , workout: template_2, nb_of_reps: 5, order_index: 3, weight: )
WorkoutSet.create!(name: "6 reps", exercise: , workout: template_2, nb_of_reps: 6, order_index: 4, weight: )
WorkoutSet.create!(name: "7 reps", exercise: , workout: template_2, nb_of_reps: 7, order_index: 5, weight: )

template_3 = Workout.create!(name: "German Volume training", template: true, user: team, pros: "increase endurance, burn alot of calories", cons: "cannot lift too heavy, cannot use type 1 muscle fibers, takes long time in gym", date: Day.now)
WorkoutSet.create!(exercise: , workout: template_3, nb_of_reps: 10, order_index: 1, weight: )
WorkoutSet.create!(exercise: , workout: template_3, nb_of_reps: 10, order_index: 2, weight: )
WorkoutSet.create!(exercise: , workout: template_3, nb_of_reps: 10, order_index: 3, weight: )
WorkoutSet.create!(exercise: , workout: template_3, nb_of_reps: 10, order_index: 4, weight: )
WorkoutSet.create!(exercise: , workout: template_3, nb_of_reps: 10, order_index: 5, weight: )
WorkoutSet.create!(exercise: , workout: template_3, nb_of_reps: 10, order_index: 6, weight: )
WorkoutSet.create!(exercise: , workout: template_3, nb_of_reps: 10, order_index: 7, weight: )
WorkoutSet.create!(exercise: , workout: template_3, nb_of_reps: 10, order_index: 8, weight: )
WorkoutSet.create!(exercise: , workout: template_3, nb_of_reps: 10, order_index: 9, weight: )
WorkoutSet.create!(exercise: , workout: template_3, nb_of_reps: 10, order_index: 10, weight: )



template_4 = Workout.create!(name: "Strength Training Routine", template: true, user: team, pros: "can increase weights faster", cons: "not focused on muscle size", date: Day.now)
WorkoutSet.create!(exercise: , workout: template_3, nb_of_reps: 5, order_index: 1, weight: )
WorkoutSet.create!(exercise: , workout: template_3, nb_of_reps: 5, order_index: 2, weight: )
WorkoutSet.create!(exercise: , workout: template_3, nb_of_reps: 5, order_index: 3, weight: )
WorkoutSet.create!(exercise: , workout: template_3, nb_of_reps: 5, order_index: 4, weight: )
WorkoutSet.create!(exercise: , workout: template_3, nb_of_reps: 5, order_index: 5, weight: )





# =========== random stations, workout, and workoutset seeds disabled until now

# Station.create!(base_incremental_weight: [0.5, 1.0, 1.5, 2.0, 2.5, 4, 5].sample,
#                 name: STATION_NAMES.sample)
                # good_for: 'hamstrings',
                # bad_for: 'glutes')

# Exercise.create!(name: "Incline Bench Press")

# stations
# p "creating stations.."
# 20.times do
#   Station.create!(base_incremental_weight: [0.5, 1.0, 1.5, 2.0, 2.5, 4, 5].sample,
#                   name: STATION_NAMES.sample)
#                   # good_for: 'hamstrings',
#                   # bad_for: 'glutes')
# end
# p "created #{Station.count} stations"

# # exercises
# p "creating exercises.."
# 20.times do
#   # array = []
#   # array.push(MUSCLES.sample)
#   # new_exercise =
#   Exercise.create!(
#                   name: EXERCISES.sample,
#                   station: Station.all.sample,
#                   muscle_list: MUSCLES.sample
#                   )
#   # puts new_exercise
#   # new_exercise.tag_list.add(MUSCLES.sample)
#   # new_exercise.save!
# end
# p "created #{Exercise.count} exercises"

# # create workout
# p "creating workout.."
# 5.times.with_index do |i|
#   specific_workout = Workout.new(name: "workout template #{i}", template: true, pros_and_con_list: "good for gaining strength")
#   specific_workout.user = User.first
#   specific_workout.save!
#   p "creating workout called: #{specific_workout.name} "

#   # create workout sets
#   3.times do
#     # get one exercise for 4 sets
#     specific_exercise = Exercise.all.sample

#     p "creating workout sets"
#     4.times do
#       new_set = WorkoutSet.new(order_index: 1, nb_of_reps: rand(5..12), weight: rand(5..20), difficulty: rand(1..3))
#       new_set.exercise = specific_exercise
#       new_set.workout = specific_workout
#       new_set.save!
#       p "workout set created for #{specific_exercise.name}"
#     end
#   end
# end


# =========== random users to be enabled later


# create users
# User.all.each do |user|
#   rand(2..10).times do
#     # create past workout
#     workout = Workout.first.clone
#     workout.user = user
#     workout.template = false
#     workout.day = Date.now
#     workout.mental_state = %w[motivated tired hungry heartbroken pumped].sample
#   end
# end
