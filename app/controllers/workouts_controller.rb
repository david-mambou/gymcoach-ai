class WorkoutsController < ApplicationController
  def new
    # add real template from workouts
    @template_workout = Workout.find_by(template: true)
    authorize @template_workout
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
    authorize @workout
    redirect_to dashboard_path
  end

  private

  def ask_gpt3
    @params = params
    if params[:question].present?
      client = OpenAI::Client.new
      client.files.upload(parameters: { file: 'db/data.jsonl', purpose: 'search' })
      response = client.answers(parameters: {
        documents: ["I bench press 3 sets of 25kg at 8 reps on july 7th, 2020 and it was easy.", "I barbell squat 20kg twice, but failed on the third set on november 1st, 2021. But it was hard."],
        question: params[:question],
        model: "davinci",
        examples_context: "In 2017, U.S. life expectancy was 78.6 years.",
        examples: [["What is human life expectancy in the United States?","78 years."]],
        max_rerank: 10,
        max_tokens: 5
      })
     @reply = response['answers']
   end
  end


  # def sanitized_params
  #   #todo
  #   params.require(:workout).permit(:name, :pros_and_con_list)
  # end
end
