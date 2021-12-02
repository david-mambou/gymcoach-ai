class WorkoutSetsController < ApplicationController
  def update
    @workout_set = WorkoutSet.find(params[:id])
    authorize @workout_set
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
    make_charts
    respond_to do |format|
      format.html { redirect_to messages_path }
      format.text { render partial: "workouts/workout_set", locals: { workout: @workout_set.workout, workout_set: @workout_set.workout.current_set }, formats: [:html] }
    end
    #todo
  end



  private

  def sanitized_params
    params.require("workout_set").permit(:nb_of_reps, :weight, :difficulty, :completed)
  end

  def make_charts
    @chart_data_weekly = {
      labels: [6.days.ago.strftime("%a, %d"), 5.days.ago.strftime("%a, %d"), 4.days.ago.strftime("%a, %d"), 3.days.ago.strftime("%a, %d"), 2.days.ago.strftime("%a, %d"), 1.days.ago.strftime("%a, %d")],
      datasets: [{
        label: 'Your Progress',
        backgroundColor: 'transparent',
        borderColor: '#3B82F6',
        data: current_user.weight_history
      }]
    }
    @chart_data_monthly = {
      labels: [29.days.ago.strftime("%b, %d"), 21.days.ago.strftime("%b, %d"), 14.days.ago.strftime("%b, %d"), 7.days.ago.strftime("%b, %d")],
      datasets: [{
        label: 'Your Progress',
        backgroundColor: '#E5E5E5',
        borderColor: '#3B82F6',
        data: current_user.weight_history,
        fill: true
      }]
    }
    @chart_options = {
      scales: {
        yAxes: [{
          ticks: {
            beginAtZero: true
          }
        }]
      }
    }
  end
end
