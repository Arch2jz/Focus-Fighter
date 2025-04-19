class Character < ApplicationRecord
  belongs_to :user
  has_many :focus_sessions, dependent: :nullify

  validates :name, presence: true
  validates :level, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :experience, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_validation :set_default_values, on: :create

  def level_up_check
    exp_needed = level * 100
    if experience >= exp_needed
      self.experience -= exp_needed
      self.level += 1
      save
    end
  end

  private

  def set_default_values
    self.level ||= 1
    self.experience ||= 0
  end
end
