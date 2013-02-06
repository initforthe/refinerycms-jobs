class AddCategoryToJobs < ActiveRecord::Migration

  def change 
    add_column :refinery_jobs, :category_id, :integer
  end

end
