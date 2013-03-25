module Refinery
  module Jobs
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Jobs

      engine_name :refinery_jobs

      config.autoload_paths += %W( #{config.root}/lib )

      initializer 'attach-refinery-jobs-with-dragonfly', :after => :load_config_initializers do |app|
        ::Refinery::Jobs::Dragonfly.configure!
        ::Refinery::Jobs::Dragonfly.attach!(app)
      end

      initializer "register refinerycms_jobs plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "jobs"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.jobs_admin_jobs_path }
          plugin.pathname = root
          plugin.menu_match = /refinery\/jobs\/?(job_applications|categories)?/
          plugin.activity = {
            :class_name => :'refinery/jobs/job',
            :title => 'reference'
          }
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Jobs)
      end
    end
  end
end
