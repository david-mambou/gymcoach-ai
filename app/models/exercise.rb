class Exercise < ApplicationRecord
  belongs_to :station
  has_one_attached :photo
  has_many :workout_sets
  acts_as_taggable_on :muscles

  # calculate one rep max to use for calculating recommended weights for sets
  def one_rep_max
    # get latest 3 sets with <=5 reps and calculate 1rpm
    reps_6 = workout_sets.where("nb_of_reps = ?", 6).limit(2).pluck(:weight)
    reps_5 = workout_sets.where("nb_of_reps = ?", 5).limit(2).pluck(:weight)
    reps_4 = workout_sets.where("nb_of_reps = ?", 4).limit(2).pluck(:weight)
    average = (reps_6.sum + reps_5.sum + reps_4.sum) / (reps_6.size + reps_5.size + reps_4.size)

    # University of New Mexico Formula
    #  https://www.menshealth.com/uk/building-muscle/a748257/how-to-calculate-one-rep-max/
    # todo implement a formula for lower body
    # test2 = (60 * 1.09703) + 14.2546 # lower body
    return (average * 1.1307) + 0.6998 # upper body
  end
end
