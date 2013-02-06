require 'refinerycms-core'
require 'dragonfly'
require 'rack/cache'

module Refinery
  autoload :JobsGenerator, 'generators/refinery/jobs_generator'

  module Jobs
    require 'refinery/jobs/engine'
    require 'refinery/jobs/configuration'

    autoload :Dragonfly, 'refinery/jobs/dragonfly'
    autoload :Validators, 'refinery/jobs/validators'

    class << self
      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join('spec', 'factories').to_s ]
      end
    end
  end
end
