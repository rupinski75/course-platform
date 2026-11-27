class Course < ApplicationRecord
  validates :title, presence: true
  has_many :sections, dependent: :destroy
  has_many :enrollments
  has_many :lessons, through: :sections
  has_many :lesson_completions, through: :lessons
end
