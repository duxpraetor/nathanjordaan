class CvController < ApplicationController
  def index
  end

  def pdf
    send_data CvPdf.new.generate,
              filename: "nathan-jordaan-cv.pdf",
              type: "application/pdf",
              disposition: "inline"
  end
end
