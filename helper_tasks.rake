require_relative 'helpers'

# Heplper tasks
desc "List files to be packaged"
task :show_files do
  puts package_files
end

desc "Show update manifest"
task :show_manifest do
  puts update_manifest
end

desc "Clean up"
task :clean do
  rm_rf "./packages"
end

