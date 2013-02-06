module Refinery
  module Jobs
    module Admin
      class JobsController < ::Refinery::AdminController
        helper ::Refinery::Jobs::JobsHelper

        crudify :'refinery/jobs/job',
                :title_attribute => 'reference', :xhr_paging => true,
                :order => 'created_at DESC', :sortable => false

      end
    end
  end
end
