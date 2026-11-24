class Section < ApplicationRecord
  belongs_to :course
  has_many :lessons, dependent: :destroy

  validates :title, presence: true

  before_create :set_default_position

  private
 
  def set_default_position
    if self.position.blank?
      parent = self.course
      self.position = parent.sections.maximum(:position).to_i + 1
    end
  end

end
