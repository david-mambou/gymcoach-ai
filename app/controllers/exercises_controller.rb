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
    @chart_data = {
      labels: [6.days.ago.strftime("%a"), 5.days.ago.strftime("%a"), 4.days.ago.strftime("%a"), 3.days.ago.strftime("%a"), 2.days.ago.strftime("%a"), 1.days.ago.strftime("%a")],
      datasets: [{
        label: 'Your Progress',
        backgroundColor: 'transparent',
        borderColor: '#3B82F6',
        data: [37, 83, 78, 54, 12, 5, 99]
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
