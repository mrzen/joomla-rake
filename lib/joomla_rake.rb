##
# Joomla Rake Master File


JRAKE_ROOT = File.dirname(File.join __FILE__)

# Load Gems
require 'bundler'
Bundler.require :default

# Load Helpers
Dir[File.join(JRAKE_ROOT, 'helpers', '*.rb')].each do |helper|
  require helper
end

Dir[File.join(JRAKE_ROOT, 'tasks', '*.rake')].each do |tasks|
  require tasks
end
