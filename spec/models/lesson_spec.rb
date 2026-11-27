require "rails_helper"

RSpec.describe "Lesson model" do
  describe "Markdown to HTML rendering" do
    let(:course)  { Course.create!(title: "Course") }
    let(:section) { course.sections.create!(title: "Section") }
    let(:lesson)  { section.lessons.create!(title: "Lesson", content: content) }
    let(:content) { "# Title" }

    it "returns html safe output" do
      expect(lesson.rendered_content).to be_html_safe
    end

    context "when the lesson markdown content is a  heading" do
      it "offsets the heading one level down" do
        html_lesson_content = lesson.rendered_content
        expect(html_lesson_content).to match(/<h2[ >]/)
      end
    end

    context "when the lesson markdown content is nil" do
      let(:content) { nil }

      it "returns nil" do
        html_lesson_content = lesson.rendered_content
        expect(html_lesson_content).to eq(nil)
      end
    end

    context "when the lesson markdown content includes a <script> tag" do
      let(:content) { "<script>alert('x!')</script>" }

      it "strips the <script> tag" do
        html_lesson_content = lesson.rendered_content
        expect(html_lesson_content).not_to include("<script>")
      end
    end
  end
end
