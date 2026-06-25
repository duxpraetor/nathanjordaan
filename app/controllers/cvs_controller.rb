class CvsController < ApplicationController
  allow_unauthenticated_access only: %i[index pdf]
  before_action :set_public_cv, only: %i[index pdf]
  before_action :require_authentication, only: %i[show edit update]
  before_action :set_my_cv, only: %i[show edit update]

  def index
  end

  def show
    redirect_to cv_index_path unless @cv
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

  def set_public_cv
    @cv = Cv.joins(:user).find_by(users: { email_address: "nathanjordaan@gmail.com" })
  end

  def set_my_cv
    @cv = Current.user&.cv
    if @cv.nil?
      @cv = Current.user.create_cv!(name: Current.user.email_address.split("@").first, email: Current.user.email_address)
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
