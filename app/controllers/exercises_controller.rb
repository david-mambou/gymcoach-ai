class ExercisesController < ApplicationController

  # exercise Index will be hidden inside app
  def index
    respond_to do |format|
      format.html
      #________________________________________\/_TODO, implement exersice list_
      format.text { render partial: 'exercise/list', locals: { exercise: @exercise }, formats: [:html] }
    end
  end

  def updated
    #TODO
  end

  def show
    @exercise = Exercise.find(params[:id])
    authorize @exercise
    @workout = Workout.new
    #todo
    @chart_data_weekly = {
      labels: [6.days.ago.strftime("%a"), 5.days.ago.strftime("%a"), 4.days.ago.strftime("%a"), 3.days.ago.strftime("%a"), 2.days.ago.strftime("%a"), 1.days.ago.strftime("%a")],
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
