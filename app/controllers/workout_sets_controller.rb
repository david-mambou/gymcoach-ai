class WorkoutSetsController < ApplicationController
  def update
    @workout_set = WorkoutSet.find(params[:id])
    authorize @workout_set
    @workout_set.update(sanitized_params)
    #   redirect_to workout_path(@workout_set.workout)
    # else
    #   @workout = @workout_set.workout
    #   render "workouts/show"
    # end
    # unable to get stimulus/ajax to work on submission action, so commented out
    respond_to do |format|
      format.html { redirect_to workout_path(@workout_set.workout)}
      format.text { render partial: "workouts/workout_set", locals: { workout: @workout_set.workout, workout_set: @workout_set, exercise: @workout_set.exercise }, formats: [:html] }
    end
    #todo
  end



  private

  def sanitized_params
    params.require("workout_set").permit(:nb_of_reps, :weight, :difficulty, :completed)
  end
end
