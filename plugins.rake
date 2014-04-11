require_relative 'helpers'

task :build_plugins do
  $package['contents']['plugins'].each do |g|
    g.last.each do |p|
      build_plugin( g.first , p )
    end
  end
end

def build_plugin(group, name)

  plugin_build_area = File.join(build_area , 'plg_'+ group + '_' + name)
  
  mkdir_p plugin_build_area

  files = Rake::FileList.new("./plugins/#{group}/#{name}/**/*")
  
  files.each do |file_name|
    new_file_name = file_name.gsub("./plugins/#{group}/#{name}",'')
    if File.directory? file_name
      mkdir_p File.join(plugin_build_area, new_file_name)
    else
      copy_to = File.join(plugin_build_area , File.dirname(new_file_name))
      mkdir_p copy_to unless File.exist? copy_to
      cp file_name, File.join( copy_to, File.basename(new_file_name))
    end
  end

  # Handle language files
  language_dirs = Dir.glob("./languages/*")
  language_dirs.each do |language_dir|
    language_code = File.basename(language_dir)
    
    language_files = Rake::FileList.new(File.join(language_dir, "#{language_code}.plg_#{group}_#{name}.*ini"))
    language_files.each do |f|
      cp f , File.join(plugin_build_area , File.basename(f))
    end
  end

  chdir(plugin_build_area) do
    sh %{zip -r ../plg_#{group}_#{name}.zip *}
  end
end

