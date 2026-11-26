class CoursesController < ApplicationController
  before_action :require_admin, except: [ :index, :show ]
  before_action :setup_course, only: [ :edit, :show, :update, :destroy ]
  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      redirect_to course_path(@course), notice: "Course has been created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def show
    @progress = current_user&.course_progress(@course)
  end

  def update
    if @course.update course_params
      redirect_to course_path(@course), notice: "Course has been updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_path
  end

  private

  def course_params
    params.expect course: [ :title, :description, :published ]
  end

  def setup_course
    @course = Course.find(params.expect(:id))
  end
end
