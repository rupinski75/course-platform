require "rails_helper"

RSpec.describe "Admin requests guard", type: :request  do
  context "a student making POST request to an authoring route" do
    it "does not create an object and redirects" do
      student = User.create!(email: "student@student.com", password: "password")
      sign_in student
      post courses_path, params: { course: { title: "Course title" } }
      expect(Course.count).to eq(0)
      expect(response).to have_http_status(:redirect)
    end
  end

  context "not logged in user making POST request to an authoring route" do
    it "does not create an object and redirects" do
      post courses_path, params: { course: { title: "Course title" } }
      expect(Course.count).to eq(0)
      expect(response).to have_http_status(:redirect)
    end
  end
end
