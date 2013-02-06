class CreateJobsJobApplications < ActiveRecord::Migration

  def change 
    create_table :refinery_job_applications do |t|
      t.string :name
      t.string :telephone
      t.string :email
      t.string :cv_uid
      t.string :cv_name
      t.text :covering_letter
      t.references :job

      t.timestamps
    end
  end

end
