module WorkoutHelper
  # retrieves all unique exercise instances from a given workout
  def retrieve_unique_exercises(workout)
    arr = []
    workout.workout_sets.each do |workout_set|
      arr.push(workout_set.exercise) unless arr.include?(workout_set.exercise)
    end
    return arr
  end
end
