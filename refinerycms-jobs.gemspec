# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-jobs'
  s.version           = '1.0'
  s.description       = 'Ruby on Rails Jobs extension for Refinery CMS'
  s.date              = '2013-02-06'
  s.summary           = 'Jobs extension for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"] + ["readme.md"]
  s.authors           = ['Initforthe']

  # Runtime dependencies
  s.add_dependency             'refinerycms-core',    '~> 2.0.5'
  s.add_dependency             'refinerycms-settings',    '~> 2.0.2'

  # Development dependencies (usually used for testing)
  s.add_development_dependency 'refinerycms-testing', '~> 2.0.5'
end
