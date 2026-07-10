class EntriesController < ApplicationController
  before_action :require_authentication
  before_action :require_cv_owner
  before_action :set_cv
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

  def require_cv_owner
    unless Current.user&.email_address == "nathanjordaan@gmail.com"
      redirect_to cv_index_path, alert: "Not authorized."
    end
  end

  def set_cv
    @cv = Cv.joins(:user).find_by(users: { email_address: "nathanjordaan@gmail.com" })
  end

  def set_section
    @section = @cv.sections.find(params.expect(:section_id))
  end

  def set_entry
    @entry = Entry.joins(section: :cv).find_by!(id: params.expect(:id), sections: { cvs: { id: @cv.id } })
    @section = @entry.section
  end

  def entry_params
    params.expect(entry: [:title, :subtitle, :date_text, :meta, :blurb, :display_order, :tag_list])
  end
end
