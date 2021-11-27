class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  has_many :workouts
  has_many :workout_sets, through: :workouts
  has_many :messages, through: :workouts
  
  has_one_attached :profile_pic

  def weight_history
    WorkoutSet.joins(:workout).where(workout: { user: self }).pluck(:weight)
  end

  def user_increment
    Station.pluck(:base_incremental_weight)
  end
end
