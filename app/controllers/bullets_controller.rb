class BulletsController < ApplicationController
  before_action :require_authentication
  before_action :require_cv_owner
  before_action :set_cv
  before_action :set_entry, only: %i[new create]
  before_action :set_bullet, only: %i[edit update destroy]

  def new
    @bullet = @entry.bullets.build
  end

  def create
    @bullet = @entry.bullets.build(bullet_params)
    if @bullet.save
      redirect_to edit_cv_path, notice: "Bullet added."
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @bullet.update(bullet_params)
      redirect_to edit_cv_path, notice: "Bullet updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @bullet.destroy
    redirect_to edit_cv_path, notice: "Bullet removed."
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

  def set_entry
    @entry = Entry.joins(section: :cv).find_by!(id: params.expect(:entry_id), sections: { cvs: { id: @cv.id } })
  end

  def set_bullet
    @bullet = Bullet.joins(entry: { section: :cv }).find_by!(id: params.expect(:id), entries: { sections: { cvs: { id: @cv.id } } })
    @entry = @bullet.entry
  end

  def bullet_params
    params.expect(bullet: [:description, :display_order, :tag_list])
  end
end
