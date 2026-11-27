class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum :role, { student: 0, admin: 1 }

  has_many :enrollments
  has_many :lesson_completions

  def course_progress(course)
    lesson_count = course.lessons.count
    completed_count = lesson_completions.where(lesson_id: course.lessons).count
    { completed_count: completed_count, lesson_count: lesson_count }
  end
end
