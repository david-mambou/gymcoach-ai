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
  end
end
