class WorkoutsController < ApplicationController
  def new
    # add real template from workouts
    @template_workout = Workout.first
    authorize @template_workout
    @messages = Message.all
    @message = Message.new

    # AI Kick off user query with a generic message if start of chat
    if Message.count == 0 
      Message.create!({
        user: current_user,
        category: "receive",
        content: "Hi, I will be your personal coach today. What would you like to do today?"
      })
    end
  end

  def create
    @workout = Workout.find(params[:template_workout])
    # assign a new variable with the instance (makes a copy)
      # new_workout = @workout.amoeba_dup
      # new_workout.pros_and_con_list.add(@workout.pros_and_con_list)
    # for amoeba, which duplicates children, tags are not duplicated, so do manually
    # new_workout.template = false
    authorize @workout
    redirect_to workout_path(@workout)
    # if new_workout.save!
    # else
    #   render :new
    # end
  end

  def show
    @workout = Workout.find(params[:id])
    authorize @workout
    #todo
  end

  def update
    @workout = Workout.find(params[:id])
    @workout.status = 2
    authorize @workout
    if @workout.save
      redirect_to dashboard_path
    else
      render :show
    end
  end

  private

  # def create_workout_groups
  #   workout_groups = []
  #   @workout.workout_sets.order(:exercise_id).each do |workout_set|
  #     workout_groups.push(workout_set) if

  # end
  # def sanitized_params
  #   #todo
  #   params.require(:workout).permit(:name, :pros_and_con_list)
  # end
end
