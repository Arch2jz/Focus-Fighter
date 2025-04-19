class FocusSession < ApplicationRecord
  belongs_to :user
  belongs_to :character

  validates :start_time, presence: true
  validates :duration, presence: true, numericality: { greater_than: 0 }
  validate :end_time_after_start_time, if: -> { start_time.present? && end_time.present? }

  after_create :award_experience_points
  
  scope :today, -> { where('start_time >= ?', Time.current.beginning_of_day) }
  scope :this_week, -> { where('start_time >= ?', Time.current.beginning_of_week) }
  scope :completed, -> { where.not(end_time: nil) }

  def completed?
    end_time.present?
  end

  def complete!
    return if completed?
    
    self.end_time = Time.current
    self.duration = ((end_time - start_time) / 60).round
    save
  end

  private

  def end_time_after_start_time
    if end_time < start_time
      errors.add(:end_time, "must be after start time")
    end
  end

  def award_experience_points
    return unless completed?
    exp_points = duration # 1 exp point per minute
    character.increment!(:experience, exp_points)
    character.level_up_check
  end
end
