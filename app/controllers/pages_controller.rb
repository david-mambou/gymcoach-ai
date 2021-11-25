class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    # clear messages before starting new session
    Message.destroy_all
  end
end
