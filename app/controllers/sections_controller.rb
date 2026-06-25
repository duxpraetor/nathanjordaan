class SectionsController < ApplicationController
  before_action :require_authentication
  before_action :set_cv
  before_action :set_section, only: %i[edit update destroy]

  def new
    @section = @cv.sections.build
  end

  def create
    @section = @cv.sections.build(section_params)
    if @section.save
      redirect_to edit_cv_path, notice: "Section added."
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @section.update(section_params)
      redirect_to edit_cv_path, notice: "Section updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @section.destroy
    redirect_to edit_cv_path, notice: "Section removed."
  end

  private

  def set_cv
    @cv = Current.user.cv
  end

  def set_section
    @section = @cv.sections.find(params.expect(:id))
  end

  def section_params
    params.expect(section: [:title, :display_order])
  end
end
