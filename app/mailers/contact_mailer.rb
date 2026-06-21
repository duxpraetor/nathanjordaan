class ContactMailer < ApplicationMailer
  def new_contact(contact)
    @contact = contact
    attachments["nathan-jordaan-cv.pdf"] = CvPdf.new.generate
    mail(
      to: contact.email,
      bcc: "nathanjordaan@gmail.com",
      subject: "Thanks for getting in touch, #{contact.full_name}"
    )
  end
end
