module Refinery
  module Jobs
    class Setting
      class << self
        def confirmation_body
          Refinery::Setting.find_or_set(:job_application_confirmation_body,
            "Thank you for your application for the role of %job_title%, %name%.\n\nThis email is a receipt to confirm we have received your application and we'll be in touch shortly.\n\nThanks."
          )
        end

        def confirmation_subject(locale='en')
          Refinery::Setting.find_or_set("job_application_confirmation_subject_#{locale}".to_sym,
                                        "Thank you for your application",
                                        :scoping => "job_applications")
        end

        def confirmation_subject=(value)
          value.first.keys.each do |locale|
            Refinery::Setting.set("job_application_confirmation_subject_#{locale}".to_sym, {
                                    :value => value.first[locale.to_sym],
                                    :scoping => "job_applications"
                                  })
          end
        end

        def confirmation_message(locale='en')
          Refinery::Setting.find_or_set("job_application_confirmation_message_#{locale}".to_sym,
                                        Refinery::Setting[:job_application_confirmation_body],
                                        :scoping => "job_applications")
        end


        def confirmation_message=(value)
          value.first.keys.each do |locale|
            Refinery::Setting.set("job_application_confirmation_message_#{locale}".to_sym, {
                                    :value => value.first[locale.to_sym],
                                    :scoping => "job_applications"
                                  })
          end
        end

        def notification_recipients
          Refinery::Setting.find_or_set(:job_application_notification_recipients,
                                        ((Refinery::Role[:refinery].users.first.email rescue nil) if defined?(Refinery::Role)).to_s,
                                        :scoping => "job_applications")
        end

        def notification_subject
          Refinery::Setting.find_or_set(:job_application_notification_subject,
                                        "New job application from your website",
                                        :scoping => "job_applications")
        end
        
        def send_confirmation?
          Refinery::Setting.find_or_set(:job_application_send_confirmation, 
                                        true,
                                        :scoping => "job_applications")
        end
      end
    end
  end
end
