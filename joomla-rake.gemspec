##
# Gemspec for Joomla Rake

Gem::Specification.new do |gem|
  gem.name = 'joomla-rake'
  gem.version = '1.0.0'
  gem.date = '2015-01-01'
  gem.summary = 'Rake tasks to build Joomla packages.'
  gem.description = 'Rake tasks to build Joomla packages using a YAML DSL'
  s.authors = ['Leo Adamek']
  s.email = 'info@mrzen.com'
  s.files = %(lib/joomla_rake.rb lib/tasks/*.rake lib/helpers/*.rb)
  s.homepage = 'http://mrzen.com'
  s.license = 'GPL2+'
end
