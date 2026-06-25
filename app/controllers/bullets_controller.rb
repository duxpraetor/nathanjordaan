class BulletsController < ApplicationController
  before_action :require_authentication
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

  def set_entry
    @entry = Entry.joins(section: :cv).find_by!(
      id: params.expect(:entry_id),
      sections: { cvs: { user_id: Current.user.id } }
    )
  end

  def set_bullet
    @bullet = Bullet.joins(entry: { section: :cv }).find_by!(
      id: params.expect(:id),
      entries: { sections: { cvs: { user_id: Current.user.id } } }
    )
    @entry = @bullet.entry
  end

  def bullet_params
    params.expect(bullet: [:description, :display_order, :tag_list])
  end
end
