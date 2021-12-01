class UsersController < ApplicationController
  def dashboard
    authorize current_user
    @today_workouts = Workout.where('day = ? AND status >= ?', Date.today, 2).order(:day)
    @upcoming_workouts = Workout.where('day > ? AND status >= ?', Date.today, 2).order(:day)
    @past_workouts = Workout.where('day < ? AND status >= ?', Date.today, 2).order(day: :desc)
    @current_workout = Workout.where('status = ?', 1).first
  end

  def goals
    #todo
  end

end
