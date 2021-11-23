class WorkoutsController < ApplicationController
  def new
    # add real template from workouts
    @template_workout = Workout.find_by(template: true)
    authorize @template_workout
  end

  def create
    @workout = Workout.find(params[:template_workout])
    # assign a new variable with the instance (makes a copy)
    new_workout = @workout.dup
    raise

    # get template sets and assign to new variable

    # save to db, route to the new workout

    @workout = Workout.new(sanitized_params)
    authorize @workout
  end

  def show
    @workout = Workout.find(params[:id])
    authorize @workout
    #todo
  end

  private

  def sanitized_params
    #todo
    params.require(:workout).permit(:name, :template)
  end
end
