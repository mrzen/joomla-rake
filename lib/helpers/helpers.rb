require 'yaml'
require 'rake'
require 'rugged'
require 'builder'
require 'logger'

# Load Configuration from package.yaml
$package = YAML.load_file("./package.yml")


Rake.application.options.quiet = true if ENV['LOUD_RAKE'].nil?

##
# Get Version Name.
#
# Version name is taken from the package description.
#
# @return [String] Verison Name
def version_name
  version = $package['package']['version'].to_s + '.' + commit_count

  ENV['JR_PACKAGE_VERSION'] ||= version
  
  version
end

##
# Get the commit count
#
# Uses the git CLI to get the commit count
#
# @return [String] Commit Count
def commit_count
  v = `git rev-list HEAD --count`
  v.strip!
end

## Get the package name
#
# @return [String] Package Name
def package_name
  "pkg_#{$package['name']}-#{version_name}#{package_tag}"
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
  "./packages/#{$package['name']}-#{version_name}#{package_tag}"
end

# Replace template values
def template( template, values )
  output = template.clone()
  values.keys.each { |key|
    output.gsub!( /{{#{key}}}/, values[ key ].to_s )
  }
  output
end


def package_tag
  branch = `git rev-parse --abbrev-ref HEAD`

  return '' if branch == 'master'

  '-' + branch.strip!
end

def update_site
  $package['package']['test_update_site'] if package_tag
  $package['package']['update_site']
end

def s3_bucket
  $package['package']['test_bucket'] if package_tag
  $package['package']['bucket']
end
