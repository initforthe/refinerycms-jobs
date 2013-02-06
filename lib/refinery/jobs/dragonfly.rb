require 'dragonfly'

module Refinery
  module Jobs
    module Dragonfly

      class << self
        def setup!
          app_jobs = ::Dragonfly[:refinery_jobs]

          app_jobs.define_macro(Refinery::Jobs::JobApplication, :file_accessor)

          app_jobs.analyser.register(::Dragonfly::Analysis::FileCommandAnalyser)
          app_jobs.content_disposition = :attachment
        end

        def configure!
          app_jobs = ::Dragonfly[:refinery_jobs]
          app_jobs.configure_with(:rails) do |c|
            c.datastore.root_path = Refinery::Jobs.datastore_root_path
            c.url_format = Refinery::Jobs.dragonfly_url_format
            c.secret = Refinery::Jobs.dragonfly_secret
          end

          if ::Refinery::Jobs.s3_backend
            app_jobs.datastore = ::Dragonfly::DataStorage::S3DataStore.new
            app_jobs.datastore.configure do |s3|
              s3.bucket_name = Refinery::Jobs.s3_bucket_name
              s3.access_key_id = Refinery::Jobs.s3_access_key_id
              s3.secret_access_key = Refinery::Jobs.s3_secret_access_key
              # S3 Region otherwise defaults to 'us-east-1'
              s3.region = Refinery::Jobs.s3_region if Refinery::Jobs.s3_region
            end
          end
        end

        def attach!(app)
          ### Extend active record ###
          app.config.middleware.insert_before Refinery::Jobs.dragonfly_insert_before,
                                              'Dragonfly::Middleware', :refinery_jobs

          app.config.middleware.insert_before 'Dragonfly::Middleware', 'Rack::Cache', {
            :verbose     => Rails.env.development?,
            :metastore   => "file:#{URI.encode(Rails.root.join('tmp', 'dragonfly', 'cache', 'meta').to_s)}",
            :entitystore => "file:#{URI.encode(Rails.root.join('tmp', 'dragonfly', 'cache', 'body').to_s)}"
          }
        end
      end

    end
  end
end
