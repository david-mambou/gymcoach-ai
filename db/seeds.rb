# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create stations

Station.create(name: 'name',
               base_incremental_weight: [0.5, 1.0, 1.5, 2.0, 2.5, 4, 5].sample)

# create exercises

Exercise.create(station: Station.first,
                title: 'title',
                muscle_group: 1,
                good_for: 'hamstrings',
                bad_for: 'glutes')

# create workout sets

Exercise.all.each do |exercise|
  WorkoutSet.create(exercise: exercise,
                    nb_of_reps: rand(5..10),
                    weight: rand(20.0...100.0),
                    difficulty_rating: rand(1..5))
end

# create workout templates

Workout.create(name: 'first template',
               template: true,
               pros_and_cons: 'Long but efficient')

4.times do
  # create user
  User.create(email: Faker::Email,
              password: 'password',
              age: rand(18..30))
end

User.all.each do |user|
  rand(2..10).times do
    # create past workout
    workout = Workout.first.clone
    workout.user = user
    workout.template = false
    workout.day = Date.now
    workout.mental_state = %w[motivated tired unmotivated].sample
  end
end
