require 'yaml'
require 'rake'
require 'rugged'
require 'builder'
require 'logger'

#
# Load Configuration from package.yaml
#
$package = YAML.load_file("./package.yml")

# Logging
$logger  = Logger.new($stdout)
$logger.level = Logger::INFO

Rake.application.options.quiet = true if ENV['SILENT_RAKE'].nil?

=begin rdoc

Get Version Name.
Version name is taken from the package description.
=end
def version_name
  $package['package']['version'].to_s + '.' + get_commit_count
end

def get_commit_count
  v = `git rev-list HEAD --count`
  v.strip!
end

# Get the package name
def package_name
  "pkg_#{$package['name']}-#{version_name}"
end


# Path file Location
def package_file_path
  "./packages/#{$package['name']}/#{package_name}.zip"
end

# Get files to (not) be packaged
# @deprecated
def package_files
  package_files = Rake::FileList.new "**/*"
  package_files.exclude(/^(packages\/.*|Rakefile|\.git|README\.md)/)

  package_files
end

# Get the build area path
def build_area
  "./packages/#{$package['name']}-#{version_name}"
end

# Replace template values
def template( template, values )
  output = template.clone()
  values.keys.each { |key|
    output.gsub!( /{{#{key}}}/, values[ key ].to_s )
  }
  output
end
