# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
p "clearing database.."
Workout.destroy_all
WorkoutSet.destroy_all
Exercise.destroy_all
Station.destroy_all
p "database cleared.."

  # Station.create(name: 'name',
  #

# static arrays
MUSCLES = ['hamstrings', 'glutes', 'quads', 'calves', 'biceps', 'triceps', 'forearms', 'shoulders', 'traps', 'abs'].freeze
STATION_NAMES = ["captains chair", "back extension machine", "incline ab bench", "ab wheel", "seated ab machine", "bench rope machine", "rack", "open space", "leg extension machine", "lying leg curl machine", "sitting calf raise machine", "pulldown machine", "pullups bar", "dumbbells", "barbell", "fly machine", "decline bench machine", "assisted rack", "preacher curl"].freeze
EXERCISES = ['wood-chops', 'planks', 'pushups', 'lunge', 'sit-ups', 'leg-raises', 'chinups', 'pullups', 'dips'].freeze

# stations
p "creating stations.."
20.times do
  Station.create!(base_incremental_weight: [0.5, 1.0, 1.5, 2.0, 2.5, 4, 5].sample,
                  name: STATION_NAMES.sample)
                  # good_for: 'hamstrings',
                  # bad_for: 'glutes')
end
p "created #{Station.count} stations"

# exercises
p "creating exercises.."
20.times do
  # array = []
  # array.push(MUSCLES.sample)
  # new_exercise =
  Exercise.create!(title: EXERCISES.sample,
                  station: Station.all.sample
                  # muscle_list: MUSCLES.sample
                )
  # puts new_exercise
  # new_exercise.tag_list.add(MUSCLES.sample)
  # new_exercise.save!
end
p "created #{Exercise.count} exercises"

# create workout
p "creating workout.."
5.times.with_index do |i|
  specific_workout = Workout.new(name: "workout template #{i}", template: true, tag_list: 'Long but efficient')
  specific_workout.user = User.first
  specific_workout.save!
  p "creating workout called: #{specific_workout.name} "

  # create workout sets
  3.times do
    # get one exercise for 4 sets
    specific_exercise = Exercise.all.sample

    p "creating workout sets"
    4.times do
      new_set = WorkoutSet.new(order_index: 1, nb_of_reps: rand(5..12), weight: rand(5..20), difficulty: rand(1..3))
      new_set.exercise = specific_exercise
      new_set.workout = specific_workout
      new_set.save!
      p "workout set created for #{specific_exercise.title}"
    end
  end
end

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
