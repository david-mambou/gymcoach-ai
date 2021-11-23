class WorkoutsController < ApplicationController
  def new
    @workout = Workout.new
    authorize @workout
    #todo
  end

  def show
    @workout = Workout.find(params[:id])
    authorize @workout
    #todo
  end

  def update
    #todo
  end

  private

  def sanitized_params
    #todo
  end

end
