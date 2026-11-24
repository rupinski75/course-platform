class LessonsController < ApplicationController
  before_action :require_admin, only: %i[new create edit update destroy]
  before_action :setup_lesson,  only: %i[show edit update destroy]
  before_action :setup_section, only: %i[new create]

  def show
  end

  def new
    @lesson  = Lesson.new
  end

  def create
    @lesson  = @section.lessons.new lesson_params
    if @lesson.save
      redirect_to lesson_path(@lesson), notice: "Lesson has been created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @lesson.update lesson_params
      redirect_to lesson_path(@lesson), notice: "Lesson has been updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @section = @lesson.section
    @lesson.destroy
    redirect_to section_path(@section), notice: "Lesson has been deleted"
  end

  private

  def setup_lesson
    @lesson = Lesson.find(params.expect(:id))
  end

  def lesson_params
    params.expect lesson: [ :title, :content, :position ]
  end

  def setup_section
    @section = Section.find(params.expect(:section_id))
  end

end
