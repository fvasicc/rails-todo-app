class Todo < ApplicationRecord
  belongs_to :user
  before_create :set_completed_false

  validates :title, presence: true
  validates :date, presence: true
  validates_presence_of :user

  has_many :comments, dependent: :destroy

  def complete
    self.completed = true
    self.completed_at = Time.zone.now
  end

  private
  def set_completed_false
    self.completed = false
  end
end

