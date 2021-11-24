class UsersController < ApplicationController
  def dashboard
    authorize current_user
  end

  def goals
    #todo
  end

end
