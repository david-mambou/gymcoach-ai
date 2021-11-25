class UsersController < ApplicationController
  def dashboard
    authorize current_user
    @upcoming_workouts = Workout.where('day > ?', Date.today)
  end

  def goals
    #todo
  end

end
