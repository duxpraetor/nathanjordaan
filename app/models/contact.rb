class Contact < ApplicationRecord
  normalizes :email, with: ->(email) { email.downcase.strip }

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :full_name, presence: true
  validates :message, presence: true
end
