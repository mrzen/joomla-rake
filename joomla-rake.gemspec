##
# Gemspec for Joomla Rake

Gem::Specification.new do |gem|
  gem.name = 'joomla-rake'
  gem.version = '1.1.0'
  gem.date = '2015-01-01'
  gem.summary = 'Rake tasks to build Joomla packages.'
  gem.description = 'Rake tasks to build Joomla packages using a YAML DSL'
  gem.authors = ['Leo Adamek']
  gem.email = 'info@mrzen.com'
  gem.files = ['lib/joomla-rake.rb', Dir['lib/helpers/*.rb'], Dir['lib/tasks/*.rb']].flatten
  gem.homepage = 'http://mrzen.com'
  gem.license = 'GPL2+'
end
