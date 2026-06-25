class EntriesController < ApplicationController
  before_action :require_authentication
  before_action :set_section, only: %i[new create]
  before_action :set_entry, only: %i[edit update destroy]

  def new
    @entry = @section.entries.build
  end

  def create
    @entry = @section.entries.build(entry_params)
    if @entry.save
      redirect_to edit_cv_path, notice: "Entry added."
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @entry.update(entry_params)
      redirect_to edit_cv_path, notice: "Entry updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @entry.destroy
    redirect_to edit_cv_path, notice: "Entry removed."
  end

  private

  def set_section
    @section = Current.user.cv.sections.find(params.expect(:section_id))
  end

  def set_entry
    @entry = Entry.joins(section: :cv).find_by!(
      id: params.expect(:id),
      sections: { cvs: { user_id: Current.user.id } }
    )
    @section = @entry.section
  end

  def entry_params
    params.expect(entry: [:title, :subtitle, :date_text, :meta, :blurb, :display_order, :tag_list])
  end
end
