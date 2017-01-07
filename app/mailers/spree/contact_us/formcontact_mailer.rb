class Spree::ContactUs::ContactMailer < Spree::BaseMailer
  def formcontact_email(formcontact)
    @formcontact = formcontact

    mail :from     => (SpreeContactUs.mailer_from || @formcontact.email),
         :reply_to => @formcontact.email,
         :subject  => (SpreeContactUs.require_subject ? @formcontact.subject : Spree.t(:subject, :email => @formcontact.email)),
         :to       => SpreeContactUs.mailer_to
  end
end
