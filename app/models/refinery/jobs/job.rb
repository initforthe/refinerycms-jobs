module Refinery
  module Jobs
    class Job < Refinery::Core::BaseModel
      self.table_name = 'refinery_jobs'

      extend FriendlyId
      friendly_id :reference_and_title, use: [:slugged]
      
      has_many :job_applications, :dependent => :destroy
      belongs_to :category
      belongs_to :user, :class_name => '::Refinery::User'

      attr_accessible :reference, :title, :job_type, :qualifications, :description, :location, :start, :duration, :position, :user_id, :category_id, :salary_from, :salary_to, :day_rate_from, :day_rate_to, :benefits, :summary

      acts_as_indexed :fields => [:reference, :title, :job_type, :qualifications, :description, :location, :duration]

      validates :reference, :presence => true, :uniqueness => true
      validates_presence_of :user_id, :reference, :title, :job_type, :description, :location, :start, :category_id

      validate :salary_or_day_rate

      def reference_and_title
        "#{reference} #{title}"
      end

      private

      def salary_or_day_rate
        if salary_from.nil? and day_rate_from.nil?
          errors.add(:base, 'Please enter either day rate or salary')
        end
      end
    end
  end
end
