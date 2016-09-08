##
# Gemspec for Joomla Rake

Gem::Specification.new do |gem|
  gem.name = 'joomla-rake'
  gem.version = '1.8.5'
  gem.date = '2016-08-11'
  gem.summary = 'Rake tasks to build Joomla packages.'
  gem.description = 'Rake tasks to build Joomla packages using a YAML DSL'
  gem.authors = ['Leo Adamek']
  gem.email = 'info@mrzen.com'
  gem.files = ['lib/joomla-rake.rb', Dir['lib/helpers/*.rb'], Dir['lib/tasks/*.rb']].flatten
  gem.homepage = 'http://mrzen.com'
  gem.license = 'GPL-2.0'

  gem.required_ruby_version = '>= 1.9.3'

  gem.add_runtime_dependency 'rake', '~> 11.2', '>= 11.2.2'
  gem.add_runtime_dependency 'builder', '~> 3.2', '>= 3.2.2'
  gem.add_runtime_dependency 'nokogiri', '~> 1.6', '>= 1.6.7.2'
  gem.add_runtime_dependency 'redcarpet', '~> 3.1', '>= 3.1.2'
end
