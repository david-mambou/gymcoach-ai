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
    @workout.status = 'active'
    @workout.workout_sets.each_with_index do |set, index|
      set.order_index = index + 1
      set.completed = false
      set.save
    end

    authorize @workout
    return unless @workout.save!

    Message.create!(category: "card_workout_set",
                    workout: @workout,
                    workout_set: @workout.workout_sets.first,
                    user: current_user)
    # make_charts
    p "Chart data weekly in workouts controller:"
    p @chart_data_weekly
    redirect_to messages_path
    # assign a new variable with the instance (makes a copy)
      # new_workout = @workout.amoeba_dup
      # new_workout.pros_and_con_list.add(@workout.pros_and_con_list)
    # for amoeba, which duplicates children, tags are not duplicated, so do manually
    # new_workout.template = false
    # if new_workout.save!
    # else
    #   render :new
    # end
  end

  def show
    # get latest active workout for user
    @workout = Workout.where(status: 'active').last || Workout.new
    authorize @workout
    make_charts
  end

  # For now, marks finished
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

  def mark_finished
    @workout = Workout.find(params[:id])
    authorize @workout
    @workout.status = 'finished'
    @workout.save
    # alert
    redirect_to dashboard_path
  end

  private

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
