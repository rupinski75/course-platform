class Course < ApplicationRecord
  validates :title, presence: true
  has_many :sections, dependent: :destroy
  has_many :enrollments
end
