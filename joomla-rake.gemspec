##
# Gemspec for Joomla Rake

Gem::Specification.new do |gem|
  gem.name = 'joomla-rake'
  gem.version = '2.3.7'
  gem.date = '2019-05-02'
  gem.summary = 'Rake tasks to build Joomla packages.'
  gem.description = 'Rake tasks to build Joomla packages using a YAML DSL'
  gem.authors = ['Leo Adamek', 'David Havard']
  gem.email = 'info@mrzen.com'
  gem.files = ['lib/joomla-rake.rb', Dir['lib/helpers/*.rb'], Dir['lib/tasks/*.rb']].flatten
  gem.homepage = 'http://mrzen.com'
  gem.license = 'GPL-2.0'

  gem.required_ruby_version = '>= 1.9.3'

  gem.add_runtime_dependency 'rake', '~> 12.0', '>= 12.0'
  gem.add_runtime_dependency 'builder', '~> 3.2', '>= 3.2.2'
  gem.add_runtime_dependency 'nokogiri', '~> 1.6', '>= 1.6.7.2'
  gem.add_runtime_dependency 'redcarpet', '~> 3.1', '>= 3.1.2'
end
