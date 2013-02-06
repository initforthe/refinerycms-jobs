module Refinery
  module Jobs
    module Validators
      class FileTypeValidator < ActiveModel::Validator

        def validate(record)
          file = record.cv

          if file.respond_to?(:mime_type) && !Jobs.mime_types.include?(file.mime_type)
            record.errors[:cv] << ::I18n.t('wrong_formats',
                                             :scope => 'activerecord.errors.models.refinery/jobs/job_application',
                                             :file_types => Jobs.file_extensions.join(', '))
          end
        end

      end
    end
  end
end
