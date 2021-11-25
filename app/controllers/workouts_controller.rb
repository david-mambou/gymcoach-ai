class WorkoutsController < ApplicationController
  def new
    # add real template from workouts
    @template_workout = Workout.find_by(template: true)
    authorize @template_workout
    @messages = Message.all
    @message = Message.new

    # AI Functionality Tests
    # muscles_used = helpers.ai_find_muscles_for_exercise("what does benchpress work on?")
    # exercise_recommendation = helpers.ai_find_exercise_for_muscle("I want to work on chest")
    # exercise_recommendation = helpers.ai_find_exercise_for_muscle("I want to work on my front delts")
    exercise_recommendation = helpers.ai_find_exercise_for_muscle("lets workout my back")
    # exercise_recommendation = helpers.ai_find_exercise_for_muscle(" I want to work back today")
    # exercise_recommendation = helpers.ai_find_exercise_for_muscle("I want to work on chest. Can you suggest something that only uses dumbbells for today? I dont want to do dumbbell bench press")
    # exercise_recommendation = helpers.ai_find_exercise_for_muscle("I am thinking to use only dumbbells today for chest")
    # direct_user_query = helpers.ai_direct_query("this workout looks too easy")
    
  end

  def create
    @workout = Workout.find(params[:template_workout])
    # assign a new variable with the instance (makes a copy)
    new_workout = @workout.amoeba_dup
    new_workout.pros_and_con_list.add(@workout.pros_and_con_list)
    # for amoeba, which duplicates children, tags are not duplicated, so do manually
    new_workout.template = false
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
