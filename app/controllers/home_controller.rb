class HomeController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    if user_signed_in?
      @active_character = current_user.active_character
      @focus_sessions = current_user.focus_sessions.today
      @todos = current_user.todos.upcoming.limit(5)
      render :dashboard
    end
  end
end
