class Lesson < ApplicationRecord
  belongs_to :section
  has_many :lesson_completions

  validates :title, presence: true

  before_create :set_default_position

  private

  def set_default_position
    if self.position.blank?
      parent = self.section
      self.position = parent.lessons.maximum(:position).to_i + 1
    end
  end
end
