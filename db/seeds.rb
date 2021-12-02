require "open-uri"
require "csv"

csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
station_filepath = "lib/csv_folder_for_presentation_seeds/simplified_station.csv"
exercise_filepath = "lib/csv_folder_for_presentation_seeds/simplified_exercise.csv"
workout_set_filepath = "lib/csv_folder_for_presentation_seeds/simplified_workoutset.csv"

###############################################################################################
# create users
p "preparing admin credentials"
User.destroy_all
psw = "pass123"
goal1 = "Increase chest size"
rtn = 'legs,chest,push'
jesse = User.create!(email: 'jesse@lewagon.com', name: 'Jesse', password: psw, password_confirmation: psw, admin: true, goal: goal1, age: 30, routine: rtn)
david = User.create!(email: 'david@lewagon.com', name: 'David', password: psw, password_confirmation: psw, admin: true, goal: goal1, age: 30, routine: rtn)
david.profile_pic.attach(io: file, filename: 'david_profile.png', content_type: 'image/png')
michael = User.create!(email: 'michael@lewagon.com', name: 'Michael', password: psw, password_confirmation: psw, admin: true, goal: goal1, age: 30, routine: rtn)
renato = User.create!(email: 'renato@lewagon.com', name: 'Renato', password: psw, password_confirmation: psw, admin: true, goal: goal1, age: 30, routine: rtn)

###############################################################################################
# clear database
p "clearing database.."
Workout.destroy_all
WorkoutSet.destroy_all
Exercise.destroy_all
Station.destroy_all
Message.destroy_all
WorkoutTemplate.destroy_all
p "database cleared.."

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

WorkoutTemplate.create!(
  name: "1 Rep Max Test (Beginner)",
  progression_curve: "0x10,0x8,0x6,0x5,0x5,0x5",
  good_for: "Ideal for Beginners, First time test",
  bad_for: "getting actual workout done")

p "Created #{WorkoutTemplate.count} workout templates"

###############################################################################################
# stations
# STATION_NAMES = ["captains chair", "back extension machine", "incline ab bench", "ab wheel", "seated ab machine", "bench rope machine", "rack", "open space", "leg extension machine", "lying leg curl machine", "sitting calf raise machine", "pulldown machine", "pullups bar", "dumbbells", "barbell", "fly machine", "decline bench machine", "assisted rack", "preacher curl"].freeze

p "creating stations.."
CSV.foreach(station_filepath, csv_options).each do |row|
  Station.create!(name: row["Name"], base_incremental_weight: row["Base incremental weight"].to_i)
end
p "created #{Station.count} stations"

###############################################################################################
# exercises
# EXERCISES = ['wood-chops', 'planks', 'pushups', 'lunge', 'sit-ups', 'leg-raises', 'chinups', 'pullups', 'dips'].freeze

p "creating exercises.."
CSV.foreach(exercise_filepath, csv_options).each do |row|
  new_exercise = Exercise.create!(name: row["Name"], muscle_list: row["Muscle group"], user_notes: row["user_notes"], good_for: row["Good for"], bad_for: row["Bad for"], station: Station.find_by(name: row["Station"]))
  file = URI.open("#{row["Photos"]}")
  p 'attaching photo to exercise..'
  new_exercise.photo.attach(io: file, filename: 'filler.png', content_type: 'image/png')
end
p "created #{Exercise.count} exercises"

###############################################################################################
# prep workout set generation
MENTAL_STATE = ['tired','hungry', 'hungover','Long Rest Before', 'Good sleep', 'headache', 'knee pain', 'elbow pain', 'good energy', 'low energy'].freeze

def gen_random_workout_set(workout, exercise)
  p "creating workout set.."
  new_set = WorkoutSet.new(order_index: 1, nb_of_reps: rand(5..12), weight: rand(5..20), difficulty: rand(1..2))
  new_set.exercise = exercise
  new_set.workout = workout
  new_set.save!
end

###############################################################################################
# workouts
p 'creating workouts'
40.times do
  specific_workout = Workout.new(name: "Push Day", mental_state: MENTAL_STATE.sample, day: Date.today + rand(-150..15))
  status = specific_workout.day <= Date.today ? 'finished' : 'active'
  specific_workout.status = status
  specific_workout.user = User.first
  specific_workout.workout_template = WorkoutTemplate.all.sample
  specific_workout.routine_tags = ['legs','chest','push'].sample
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
