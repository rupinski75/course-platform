class Lesson < ApplicationRecord
  belongs_to :section
  has_many :lesson_completions

  validates :title, presence: true

  before_create :set_default_position

   def rendered_content
     unless content.blank?
      sanitizer = Rails::Html::SafeListSanitizer.new
      html_tags = %w[h1 h2 h3 p strong em a ul ol li code pre blockquote table thead tbody tr td th sup]
      html_content = Kramdown::Document.new(content, input: "GFM").to_html
      sanitizer.sanitize(html_content, tags: html_tags, attributes: %w[href]).html_safe
     end
  end

  private

  def set_default_position
    if self.position.blank?
      parent = self.section
      self.position = parent.lessons.maximum(:position).to_i + 1
    end
  end
end
