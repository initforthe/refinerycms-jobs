module Refinery
  module Jobs
    class JobApplication < Refinery::Core::BaseModel
      self.table_name = 'refinery_job_applications'
      ::Refinery::Jobs::Dragonfly.setup!

      include Validators

      belongs_to :job

      attr_accessible :job_id, :name, :telephone, :email, :cv, :retained_cv, :covering_letter, :oops

      attr_accessor :oops
      validates :oops, :length => { :is => 0 }

      file_accessor :cv
      validates :cv, :presence => true
      validates_with FileSizeValidator
      validates_with FileTypeValidator

      validates_presence_of :name
      validate :telephone_or_email

      acts_as_indexed :fields => [:name, :covering_letter]

      private

      def telephone_or_email
        if email.blank? and telephone.blank?
          errors.add(:email, 'need one method of contact')
          errors.add(:telephone, 'need one method of contact')
        end
      end

    end
  end
end
