class SectionsController < ApplicationController
  before_action :require_authentication
  before_action :require_cv_owner
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

  def require_cv_owner
    unless Current.user&.email_address == "nathanjordaan@gmail.com"
      redirect_to cv_index_path, alert: "Not authorized."
    end
  end

  def set_cv
    @cv = Cv.joins(:user).find_by(users: { email_address: "nathanjordaan@gmail.com" })
  end

  def set_section
    @section = @cv.sections.find(params.expect(:id))
  end

  def section_params
    params.expect(section: [:title, :display_order])
  end
end
