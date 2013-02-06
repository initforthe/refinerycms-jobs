class CreateJobsJobs < ActiveRecord::Migration

  def up
    create_table :refinery_jobs do |t|
      t.string :reference
      t.string :title
      t.string :job_type
      t.string :qualifications
      t.text :description
      t.string :location
      t.date :start
      t.string :duration
      t.string :salary
      t.integer :position
      t.string :slug
      t.references :user

      t.timestamps
    end

    add_index :refinery_jobs, :reference, unique: true
    add_index :refinery_jobs, :title
    add_index :refinery_jobs, :slug, unique: true

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-jobs"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/jobs/jobs"})
    end

    drop_table :refinery_jobs

  end

end
