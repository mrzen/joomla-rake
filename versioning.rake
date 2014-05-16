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

  commit_and_tag_version($package['package']['version'] , new_version)
  

  new_version
end


def commit_and_tag_version(old_version, new_version)

  require 'rugged'
  repo = Rugged::Repository.discover nil

  oid = repo.write("Version Upgrade (#{old_version} → #{new_version})" , :blob)
  index = Rugged::Index.new
  index.add(:path => './package.yml', :oid => oid)

  options = {}
  options[:tree] = index.write_tree(repo)
  
  options[:message] = "Version Upgrade: #{old_version} → #{new_version}"
  options[:parents] = [repo.head.target].compact
  options[:update_ref] = 'HEAD'

  tagged_commit = Rugged::Commit.create(repo, options)

  Rugged::Tag.create(repo, {:name => "Version #{new_version}", :target => tagged_commit.oid}

)
  

end

desc "Increase the version number by 1 PATCH"
task :bump do |t|
  puts "Version upgrade: #{version_name} → #{bump_version}"
end
