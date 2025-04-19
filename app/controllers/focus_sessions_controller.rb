class FocusSessionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_focus_session, only: [:show, :destroy, :complete]

  def index
    @focus_sessions = current_user.focus_sessions.order(created_at: :desc)
    @total_minutes_today = @focus_sessions.today.sum(:duration)
    @total_minutes_week = @focus_sessions.this_week.sum(:duration)
  end

  def show
  end

  def new
    @focus_session = current_user.focus_sessions.build
    @characters = current_user.characters
  end

  def create
    @focus_session = current_user.focus_sessions.build(focus_session_params)
    @focus_session.start_time = Time.current
    
    if @focus_session.save
      redirect_to @focus_session, notice: 'Focus session started!'
    else
      @characters = current_user.characters
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @focus_session.destroy
    redirect_to focus_sessions_url, notice: 'Focus session was deleted.'
  end

  def complete
    if @focus_session.complete!
      redirect_to focus_sessions_path, notice: 'Focus session completed!'
    else
      redirect_to @focus_session, alert: 'Could not complete focus session.'
    end
  end

  def stats
    @total_sessions = current_user.focus_sessions.count
    @total_minutes = current_user.focus_sessions.sum(:duration)
    @daily_averages = current_user.focus_sessions
      .group_by_day(:start_time)
      .sum(:duration)
  end

  private

  def set_focus_session
    @focus_session = current_user.focus_sessions.find(params[:id])
  end

  def focus_session_params
    params.require(:focus_session).permit(:duration, :character_id)
  end
end
