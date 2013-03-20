module Refinery
  module Jobs
    class JobApplicationMailer < ActionMailer::Base
      def confirmation(application, request)
        @job_application = application
        mail :subject   => Refinery::Jobs::Setting.confirmation_subject(Globalize.locale),
             :to        => application.email,
             :from      => "\"#{Refinery::Core.site_name}\" <no-reply@#{request.domain}>",
             :reply_to  => Refinery::Jobs::Setting.notification_recipients.split(',').first
      end

      def notification(application, request)
        @job_application = application
        attachments[@job_application.cv_name] = @job_application.cv.file.read
        mail :subject   => Refinery::Jobs::Setting.notification_subject,
             :to        => Refinery::Jobs::Setting.notification_recipients,
             :from      => "\"#{Refinery::Core.site_name}\" <no-reply@#{request.domain}>",
             :reply_to  => application.email
      end
    end
  end
end
