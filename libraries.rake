# -*- coding: utf-8 -*-
require_relative 'helpers'

task :build_libraries do
  $package['contents']['libraries'].each do |lib|
    build_library lib
  end
end

def build_library(name)
  lib_build_area = File.join(build_area , 'lib_' + name)
    
  mkdir_p lib_build_area
  files = Rake::FileList.new("./libraries/#{name}/**/*")
  
  files.each do |file_name|
    new_file_name = file_name.gsub("./libraries/#{name}/",'')
    if File.directory?(file_name)
      mkdir_p File.join(lib_build_area, new_file_name)
    else
      copy_to = File.join(lib_build_area , File.dirname(new_file_name))
      mkdir_p copy_to unless File.exist?(copy_to)
      cp file_name, File.join(copy_to , File.basename(file_name))
    end
  end

  manifest_path = File.join(lib_build_area, name + '.xml')
  manifest_file = File.open(manifest_path , 'w')
  manifest = Builder::XmlMarkup.new(:indent => 2, :target => manifest_file)
  
  manifest.instruct!

  manifest.extension({
                       :type => "library",
                       :version => $package['package']['target_version'],
                       :method => "upgrade"}) do |ext|
    ext.name "#{name.capitalize} Library"
    ext.libraryname "lib_" + name
    ext.version version_name
    ext.copyright $package['package']['copyright']
    ext.creationDate "01 Jen 2010"
    ext.author $package['package']['author']
    ext.authorEmail $package['package']['author_email']
    ext.authorUrl $package['package']['author_url']
    
    ext.files do |files|
      chdir(lib_build_area) do
        Dir.glob('*').each do |f|
          if File.directory? f
            files.folder f
          else
            files.file f
          end # File.directory?
        end # Dir.glob.each
      end # chdir
    end # ext.files
  end # ext

  manifest.target!
  manifest_file.flush
  manifest_file.close

  chdir(lib_build_area) do
    sh %{zip -r ../lib_#{name}.zip *}
  end
end
