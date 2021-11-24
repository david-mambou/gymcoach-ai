class WorkoutSetsController < ApplicationController
  def update
    @workout_set = WorkoutSet.find(params[:id])
    authorize @workout_set
    @workout_set.update(sanitized_params)
    if @workout_set.save
      redirect_to workout_path(@workout_set.workout)
    else
      render "workouts/show"
    end
    #todo
  end

  private

  def sanitized_params
    params.require("workout_set").permit(:nb_of_reps, :weight, :completed)
  end
end
