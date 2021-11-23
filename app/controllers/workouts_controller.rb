class WorkoutsController < ApplicationController
  def new
    # add real template from workouts
    @template_workout = Workout.find_by(template: true)
    authorize @template_workout
  end

  def create
    @workout = Workout.find(params[:template_workout])
    # assign a new variable with the instance (makes a copy)
    new_workout = @workout.amoeba_dup

    authorize @workout

    if new_workout.save!
      redirect_to workout_path(new_workout)
    else
      render :new
    end
  end

  def show
    @workout = Workout.find(params[:id])
    authorize @workout
    #todo
  end

  def update
    @workout = Workout.find(params[:id])
    authorize @workout
    redirect_to dashboard_path
  end

  private

  def sanitized_params
    #todo
    params.require(:workout).permit(:name, :template)
  end
end
