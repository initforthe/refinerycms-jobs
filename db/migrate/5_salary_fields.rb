class SalaryFields < ActiveRecord::Migration

  def change
    add_column :refinery_jobs, :summary, :text
    add_column :refinery_jobs, :salary_from, :integer
    add_column :refinery_jobs, :salary_to, :integer
    add_column :refinery_jobs, :day_rate_from, :integer
    add_column :refinery_jobs, :day_rate_to, :integer
    add_column :refinery_jobs, :benefits, :string
    remove_column :refinery_jobs, :salary

    add_index :refinery_jobs, :salary_from
    add_index :refinery_jobs, :day_rate_from
  end

end
