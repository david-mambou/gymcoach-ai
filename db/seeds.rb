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
Message.destroy_all
WorkoutTemplate.destroy_all
p "database cleared.."

  # Station.create(name: 'name',
  #

# static arrays
MUSCLES = ['hamstrings', 'glutes', 'pecs', 'deltoids', 'quads', 'calves', 'biceps', 'erector spinae' 'triceps', 'forearms', 'shoulders', 'traps', 'abs', 'obliques', 'trapezius', 'lats', 'glutes'].freeze
STATION_NAMES = ["captains chair", "back extension machine", "incline ab bench", "ab wheel", "seated ab machine", "bench rope machine", "rack", "open space", "leg extension machine", "lying leg curl machine", "sitting calf raise machine", "pulldown machine", "pullups bar", "dumbbells", "barbell", "fly machine", "decline bench machine", "assisted rack", "preacher curl"].freeze
EXERCISES = ['wood-chops', 'planks', 'pushups', 'lunge', 'sit-ups', 'leg-raises', 'chinups', 'pullups', 'dips'].freeze
MENTAL_STATE = ['tired','hungry', 'hungover','Long Rest Before', 'Good sleep', 'headache', 'knee pain', 'elbow pain', 'good energy', 'low energy'].freeze

def gen_random_workout_set(workout, exercise)
  p "creating workout set.."
  new_set = WorkoutSet.new(order_index: 1, nb_of_reps: rand(5..12), weight: rand(5..20), difficulty: rand(1..2))
  new_set.exercise = exercise
  new_set.workout = workout
  new_set.save!
end

###############################################################################################

# workout templates
p 'generating workout templates..'
WorkoutTemplate.create!(
  name: "German Volume Training", 
  progression_curve: "40x10,40x10,40x10,40x10,40x10,40x10,40x10,40x10,40x10,40x10",
  good_for: "Improving endurance, Fewer Gym Workouts Per Week, High Volume",
  bad_for: "Sore Body Common, Not good for strength, fewer exercises per gym session")

WorkoutTemplate.create!(
  name: "Pyramid 12/10/8/15", 
  progression_curve: "60x12,70x10,80x8,50x15",
  good_for: "Covers 8-12 hypertrophy range",
  bad_for: "Requires 4 or more sets with same muscles for best results.")
  
WorkoutTemplate.create!(
  name: "3/7 Method", 
  progression_curve: "60x12,70x10,80x8,50x15",
  good_for: "Great for short gym sessions",
  bad_for: "")

p "Created #{WorkoutTemplate.count} workout templates"

###############################################################################################

# stations
p "creating stations.."
20.times do
  Station.create!(base_incremental_weight: [0.5, 1.0, 1.5, 2.0, 2.5, 4, 5].sample,
                  name: STATION_NAMES.sample)
                  # good_for: 'hamstrings',
                  # bad_for: 'glutes')
end
p "created #{Station.count} stations"

###############################################################################################

# exercises
p "creating exercises.."
20.times do
  # array = []
  # array.push(MUSCLES.sample)
  # new_exercise =
  Exercise.create!(
                  name: EXERCISES.sample,
                  station: Station.all.sample,
                  muscle_list: MUSCLES.sample
                  )
  # puts new_exercise
  # new_exercise.tag_list.add(MUSCLES.sample)
  # new_exercise.save!
end
p "created #{Exercise.count} exercises"

###############################################################################################

# create workout templates
p "creating workout templates.."
5.times.with_index do |i|
  specific_workout = Workout.new(name: "workout template #{i}", status: 'active')
  specific_workout.user = User.first
  specific_workout.save!
  p "creating workout called: #{specific_workout.name} "

  # create workout sets
  3.times do
    # get one exercise for 4 sets
    specific_exercise = Exercise.all.sample
    4.times do
      gen_random_workout_set(specific_workout, specific_exercise)
    end
  end
end
###############################################################################################

p 'creating push workout'
40.times do
  specific_workout = Workout.new(name: "Push Day", mental_state: MENTAL_STATE.sample, day: Date.today + rand(-150..15))
  status = specific_workout.day <= Date.today ? 'finished' : 'active'
  specific_workout.status = status
  specific_workout.user = User.first
  specific_workout.save!
  p "creating workout: #{specific_workout.name}"

  # create workout sets
  3.times do
    # get one exercise for 4 sets
    specific_exercise = Exercise.all.sample
    4.times do
      gen_random_workout_set(specific_workout, specific_exercise)
    end
  end
end

###############################################################################################

# create users
# User.all.each do |user|
#   rand(2..10).times do
#     # create past workout
#     workout = Workout.first.clone
#     workout.user = user
#     workout.day = Date.now
#     workout.mental_state = %w[motivated tired hungry heartbroken pumped].sample
#   end
# end
