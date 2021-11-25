class UsersController < ApplicationController
  def dashboard
    authorize current_user
    @today_workouts = Workout.where('day = ?', Date.today).order(:day)
    @upcoming_workouts = Workout.where('day > ?', Date.today).order(:day)
    @past_workouts = Workout.where('day < ?', Date.today).order(day: :desc)
  end

  def goals
    #todo
  end

end
