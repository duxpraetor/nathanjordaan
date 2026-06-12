class ContactMailer < ApplicationMailer
  def new_contact(contact)
    @contact = contact
    cv = Cv.joins(:user).find_by(users: { email_address: "nathanjordaan@gmail.com" })
    attachments["#{cv.name.parameterize}-cv.pdf"] = CvPdf.new(cv).generate
    mail(
      to: contact.email,
      bcc: "nathanjordaan@gmail.com",
      subject: "Thanks for getting in touch, #{contact.full_name}"
    )
  end
end
