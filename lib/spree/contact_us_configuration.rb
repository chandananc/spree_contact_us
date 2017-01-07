class Spree::ContactUsConfiguration < Spree::Preferences::Configuration
  preference :formcontact_tracking_message, :string, :default => nil
end
