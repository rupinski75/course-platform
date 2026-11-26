class CompletionsController < ApplicationController
  before_action :authenticate_user!
  before_action :setup_lesson

  def create
    @lesson_completion = current_user.lesson_completions.new(lesson: @lesson)
    if @lesson_completion.save
      redirect_to lesson_path(@lesson), notice: "Lesson marked as completed!"
    else
      redirect_to lesson_path(@lesson), alert: "Lesson already completed!"
    end
  rescue ActiveRecord::RecordNotUnique
    redirect_to lesson_path(@lesson), alert: "Lesson already completed!"
  end

  def destroy
    @lesson_completion = current_user.lesson_completions.find_by(lesson: @lesson)
    if @lesson_completion&.destroy
      redirect_to lesson_path(@lesson), notice: "Completion removed!"
    else
      redirect_to lesson_path(@lesson), alert: "This lesson was not completed"
    end
  end

  private

  def setup_lesson
    @lesson = Lesson.find(params.expect(:lesson_id))
  end
end
