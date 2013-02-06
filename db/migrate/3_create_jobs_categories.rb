class CreateJobsCategories < ActiveRecord::Migration

  def change 
    create_table Refinery::Jobs::Category.table_name do |t|
      t.string :name
      t.timestamps
    end
  end

end
