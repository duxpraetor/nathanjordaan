class CvController < ApplicationController
  allow_unauthenticated_access only: %i[index pdf]
  before_action :set_public_cv, only: %i[index pdf]

  def index
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
end
