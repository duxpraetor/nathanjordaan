class CvsController < ApplicationController
  allow_unauthenticated_access only: %i[index pdf]
  before_action :set_cv
  before_action :require_authentication, only: %i[edit update]
  before_action :require_cv_owner, only: %i[edit update]

  def index
  end

  def edit
  end

  def update
    if @cv.update(cv_params)
      redirect_to edit_cv_path, notice: "CV updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def pdf
    send_data CvPdf.new(@cv).generate,
              filename: "#{@cv.name.parameterize}-cv.pdf",
              type: "application/pdf",
              disposition: "inline"
  end

  private

  def set_cv
    @cv = Cv.joins(:user).find_by(users: { email_address: "nathanjordaan@gmail.com" })
  end

  def require_cv_owner
    unless Current.user&.email_address == "nathanjordaan@gmail.com"
      redirect_to cv_index_path, alert: "You are not authorized to edit this CV."
    end
  end

  def cv_params
    params.expect(cv: [ :name, :email, :summary, :github_url, :website_url, :tag_list,
      sections_attributes: [ :id, :title, :display_order, :_destroy,
        entries_attributes: [ :id, :title, :subtitle, :date_text, :meta, :blurb, :display_order, :_destroy,
          bullets_attributes: [ :id, :description, :display_order, :_destroy ]
        ]
      ]
    ])
  end
end
