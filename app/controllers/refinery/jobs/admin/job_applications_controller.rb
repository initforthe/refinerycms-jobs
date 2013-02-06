module Refinery
  module Jobs
    module Admin
      class JobApplicationsController < ::Refinery::AdminController

        crudify :'refinery/jobs/job_application',
                :title_attribute => 'name', :xhr_paging => true,
                :order => 'name ASC'

        def show
          @job_application = JobApplication.find params[:id]
        end

        def find_all_job_applications
          if params[:job_id]
            @job = Job.find params[:job_id]
            @job_applications = @job.job_applications
          else
            @job_applications = JobApplication
          end
        end

      end
    end
  end
end
