module Refinery
  module Jobs
    class JobsController < ::ApplicationController

      before_filter :find_all_jobs
      before_filter :find_page

      def index
        if params[:search] && params[:search][:input]
          @jobs = Job.with_query "^\"#{params[:search][:input]}\""
        end
        @jobs = @jobs.paginate(page: params[:page], per_page: params[:per_page])
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @job in the line below:
        present(@page)

        respond_to do |format|
          format.html
          format.json { render :json => @jobs, :methods => [:slug, :reference_and_title] }
        end
      end

      def show
        @job = Job.find(params[:id])
        @job_application = @job.job_applications.new(params[:job_application])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @job in the line below:
        present(@job)
      end

      def apply
        @job = Job.find(params[:id])
        @job_application = @job.job_applications.new(params[:job_application])

        present(@page)
        if @job_application.save
          redirect_to refinery.jobs_job_path(@job), flash: { success: 'Thank you for your application' }
        else
          render 'show'
        end
      end

    protected

      def find_all_jobs
        if params[:sort_by]
          sort_by = case params[:sort_by]
                    when 'Location' then 'location'
                    when 'Salary' then 'salary'
                    end
          @jobs = Job.order("#{sort_by} ASC") if sort_by
        else
          @jobs = Job.order('created_at DESC')
        end
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/jobs").first
      end

    end
  end
end
