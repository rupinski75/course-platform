class EnrollmentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @course = Course.find(course_param)
    @enrollment = current_user.enrollments.new(course: @course)
    if @enrollment.save
      redirect_to course_path(@course), notice: "Successfully enrolled!"
    else
      redirect_to course_path(@course), alert: "You are already enrolled"
    end
  rescue ActiveRecord::RecordNotUnique
    redirect_to course_path(@course), alert: "You are already enrolled"
  end

  def destroy
    @enrollment = current_user.enrollments.find_by(course: course_param)
    if @enrollment&.destroy
      redirect_to course_path(course_param), notice: "Unenrolled!"
    else
      redirect_to course_path(course_param), alert: "You are not enrolled in this course!"
    end
  end

  private

  def course_param
    params.expect(:course_id)
  end

end
