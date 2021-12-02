class WorkoutSetsController < ApplicationController
  def update
    @workout_set = WorkoutSet.find(params[:id])
    authorize @workout_set
    # binding.pry
    # params[:difficulty] = params[:difficulty].to_i if params[:difficulty]
    @workout_set.update(sanitized_params)
    @workout_set.completed = @workout_set.difficulty.present?
    @workout_set.save!
    #   redirect_to workout_path(@workout_set.workout)
    # else
    #   @workout = @workout_set.workout
    #   render "workouts/show"
    # end
    # unable to get stimulus/ajax to work on submission action, so commented out
    sleep(1.5)

    respond_to do |format|
      format.html { redirect_to messages_path }
      format.text { render partial: "workouts/workout_set", locals: { workout: @workout_set.workout, workout_set: @workout_set.workout.current_set }, formats: [:html] }
    end
    #todo
  end



  private

  def sanitized_params
    sanitized_params = params.require("workout_set").permit(:nb_of_reps, :weight, :difficulty, :completed)
    sanitized_params[:difficulty] = sanitized_params[:difficulty].to_i
    sanitized_params
  end
end
