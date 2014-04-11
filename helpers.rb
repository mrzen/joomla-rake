require 'yaml'
require 'rake'
require 'rugged'
require 'builder'
require 'logger'

#
# Load Configuration from package.yaml
#
$package = YAML.load_file("./package.yaml")

# Logging
$logger  = Logger.new($stdout)
$logger.level = Logger::INFO

Rake.application.options.quiet = true if ENV['SILENT_RAKE'].nil?

=begin rdoc

Get Version Name.
Version name is:
* The first 8 characters of the latest commit ID
* The branch name
=end
def version_name
  require 'rugged'
  repository = Rugged::Repository.new Rugged::Repository.discover "."
  reference  = repository.head
  
  commit_id = reference.log.last[:id_new]
  commit_count   = reference.log.length
  branch_name = reference.name.split("/").last

  $package['package']['version'].to_s + '.' + commit_id[0..8] + "-" + branch_name
  # commit_count.to_s + '-' + branch_name
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
