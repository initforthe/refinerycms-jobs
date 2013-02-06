module Refinery
  module Jobs
    module Admin
      class CategoriesController < ::Refinery::AdminController

        crudify :'refinery/jobs/category',
                :title_attribute => 'name',
                :order => 'name ASC'

      end
    end
  end
end
