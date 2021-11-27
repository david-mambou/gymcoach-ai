class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    # clear messages before starting new session
    @current_user = current_user
    # current_user.messages.destroy_all if @current_user
  end
end
