class ContactMailer < ApplicationMailer
  default from: "nathanjordaan@gmail.com"

  def new_contact(contact)
    @contact = contact
    attachments["nathan-jordaan-cv.pdf"] = CvPdf.new.generate
    mail(
      to: "nathanjordaan@gmail.com",
      subject: "New contact from #{contact.full_name}"
    )
  end
end
