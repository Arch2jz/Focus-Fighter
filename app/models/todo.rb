class Todo < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :due_date, presence: true
  
  scope :completed, -> { where(completed: true) }
  scope :pending, -> { where(completed: false) }
  scope :upcoming, -> { where(completed: false).where('due_date > ?', Time.current).order(due_date: :asc) }
  scope :overdue, -> { where(completed: false).where('due_date < ?', Time.current).order(due_date: :desc) }

  before_create :set_default_completed

  private

  def set_default_completed
    self.completed ||= false
  end
end
