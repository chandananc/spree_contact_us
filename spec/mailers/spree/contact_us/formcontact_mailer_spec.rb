require 'spec_helper'

describe Spree::ContactUs::ContactMailer do

  describe "#formcontact_email" do

    before do
      SpreeContactUs.mailer_to = "contact@please-change-me.com"
      @formcontact = Spree::ContactUs::Formcontact.new(:email => 'test@email.com', :message => 'Thanks!')
    end

    it "should render successfully" do
      lambda { Spree::ContactUs::FormcontactMailer.formcontact_email(@formcontact) }.should_not raise_error
    end

    it "should use the ContactUs.mailer_from setting when it is set" do
      SpreeContactUs.mailer_from = "contact@please-change-me.com"
      @mailer = Spree::ContactUs::FormcontactMailer.formcontact_email(@formcontact)
      @mailer.from.should eql([SpreeContactUs.mailer_from])
      SpreeContactUs.mailer_from = nil
    end

    describe "rendered without error" do

      before do
        @mailer = Spree::ContactUs::FormcontactMailer.formcontact_email(@formcontact)
      end

      it "should have the initializers to address" do
        @mailer.to.should eql([SpreeContactUs.mailer_to])
      end

      it "should use the users email in the from field when ContactUs.mailer_from is not set" do
        @mailer.from.should eql([@formcontact.email])
      end

      it "should use the users email in the reply_to field" do
        @mailer.reply_to.should eql([@formcontact.email])
      end

      it "should have users email in the subject line" do
        @mailer.subject.should eql("Contact Us message from #{@formcontact.email}")
      end

      it "should have the message in the body" do
        @mailer.body.should match("<p>Thanks!</p>")
      end

      it "should deliver successfully" do
        lambda { Spree::ContactUs::ContactMailer.formcontact_email(@formcontact).deliver }.should_not raise_error
      end

      describe "and delivered" do

        it "should be added to the delivery queue" do
          lambda { Spree::ContactUs::ContactMailer.formcontact_email(@formcontact).deliver }.should change(ActionMailer::Base.deliveries,:size).by(1)
        end

      end

    end

  end

end
