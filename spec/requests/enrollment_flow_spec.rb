require "rails_helper"

RSpec.describe "Enrollment and completion flow", type: :request do

  context "normal user flow with content present" do

    it "enrolls, completes a lesson and renders the completion ring" do
      user = User.create!(email: "email2@email.com", password: "password")
      course  = Course.create!(title: "Course title")
      section = course.sections.create!(title: "Section title")
      lesson  = section.lessons.create!(title: "Lesson")
      sign_in user
      post course_enrollment_path(course)
      expect(user.enrollments.count).to eq(1)
      expect(response).to redirect_to(course_path(course))
      post lesson_completion_path(lesson)
      expect(LessonCompletion.all.count).to eq(1)
      get course_path(course)
      expect(response.body).to include("svg")
      expect(response).to have_http_status(:ok)
    end

  end

  context "when a student tries to enroll two times for a course" do
    it "does not create duplicate enrollment and redirects" do
      user = User.create!(email: "email2@email.com", password: "password")
      course  = Course.create!(title: "Course title")
      sign_in user
      post course_enrollment_path(course)
      post course_enrollment_path(course)
      expect(user.enrollments.count).to eq(1)
      expect(response).to have_http_status(:redirect)
    end
  end

end
