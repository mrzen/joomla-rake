# -*- coding: utf-8 -*-
require_relative 'helpers'


def next_version(current_version)
  # Semantic Versioning Bump
  v = current_version.split '.'
  
  # Increase PATCH version
  v[-1] = v[-1].to_i + 1

  v.join '.'
end

def bump_version
  version_file = File.read("./package.yml")
  old_version_line = version_file[/^\s{2}version:\s*[\d\.]+$/]
  new_version = next_version($package['package']['version'])
  
  version_file.sub!( old_version_line , "  version: #{new_version}")
  
  File.write("./package.yml", version_file)

  new_version
end

desc "Increase the version number by 1 PATCH"
task :bump do |t|
  puts "Version upgrade: #{version_name} → #{bump_version}"
end
