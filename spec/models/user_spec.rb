require "rails_helper"

RSpec.describe User do
  describe "#course_progress" do
    
    it "returns completed and total lesson counts of that course" do
      user = User.create!(email: "email@email.com", password: "password")
      course1 = Course.create!(title: "Course 1 title")
      course1_section = course1.sections.create!(title: "section")
      5.times do |i|
        course1_section.lessons.create!(title: "title #{i}")
      end
      course2 = Course.create!(title: "Course 2 title")
      course2_section = course2.sections.create!(title: "section")
      5.times do |i|
        course2_section.lessons.create!(title: "title #{i}")
      end
      user.lesson_completions.create!(lesson: course1_section.lessons.first)
      user.lesson_completions.create!(lesson: course1_section.lessons.last)
      expect(user.course_progress(course1)).to eq(completed_count: 2, lesson_count: 5)
    end

    it "does not count another course's completions" do
      user = User.create!(email: "email@email.com", password: "password")
      course1 = Course.create!(title: "Course 1 title")
      course1_section = course1.sections.create!(title: "section")
      5.times do |i|
        course1_section.lessons.create!(title: "title #{i}")
      end
      course2 = Course.create!(title: "Course 2 title")
      course2_section = course2.sections.create!(title: "section")
      5.times do |i|
        course2_section.lessons.create!(title: "title #{i}")
      end
      user.lesson_completions.create!(lesson: course1_section.lessons.first)
      user.lesson_completions.create!(lesson: course1_section.lessons.last)
      user.lesson_completions.create!(lesson: course2_section.lessons.first)
      expect(user.course_progress(course1)).to eq(completed_count: 2, lesson_count: 5)
      expect(user.course_progress(course2)).to eq(completed_count: 1, lesson_count: 5)
    end

  end
end
