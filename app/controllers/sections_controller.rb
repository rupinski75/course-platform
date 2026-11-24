class SectionsController < ApplicationController
  before_action :require_admin, only: %i[new create edit update destroy]
  before_action :setup_section, only: [ :show, :update, :edit, :destroy ]
  before_action :setup_course,  only: [ :new, :create ]

  def show
  end

  def new
    @section = Section.new
  end

  def create
    @section = @course.sections.new(section_params)
    if @section.save
      redirect_to section_path(@section), notice: "Section has been created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @section.update section_params
      redirect_to section_path(@section), notice: "Section has been updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @course = @section.course
    @section.destroy
    redirect_to course_path(@course), notice: "Section has been deleted" 
  end

  private

  def section_params
    params.expect section: [ :title, :position ]
  end

  def setup_section
    @section = Section.find(params.expect(:id))
  end

  def setup_course
    @course = Course.find(params.expect(:course_id))
  end
end
