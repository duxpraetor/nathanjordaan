class ApplicationMailer < ActionMailer::Base
  default from: -> { Rails.application.credentials.dig(:gmail, :user_name) || "nathanjordaan@gmail.com" }
  layout "mailer"
end
