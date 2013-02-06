module Refinery
  module Jobs
    module Validators
      class FileSizeValidator < ActiveModel::Validator

        def validate(record)
          file = record.cv

          if file.respond_to?(:length) && file.length > Jobs.max_file_size
            record.errors[:file] << ::I18n.t('too_big',
                                             :scope => 'activerecord.errors.models.refinery/jobs/job_application',
                                             :size => Jobs.max_file_size)
          end
        end

      end
    end
  end
end
