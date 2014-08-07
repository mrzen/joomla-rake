require_relative 'helpers'

task :build_plugins do
  if $package['contents'].keys.include? 'plugins'
      $package['contents']['plugins'].each do |g|
      g.last.each do |p|
        build_plugin( g.first , p )
      end
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
  language_dirs = Dir.glob("./administrator/language/*")
  language_dirs.each do |language_dir|
    language_code = File.basename(language_dir)
    
    language_files = Rake::FileList.new(File.join(language_dir, "#{language_code}.plg_#{group}_#{name}.*ini"))
    language_files.each do |f|
      cp f , File.join(plugin_build_area , File.basename(f))
    end
  end

  # Update the manifest meta data:
  manifest_file = "#{plugin_build_area}/#{name}.xml"
  manifest = ''

  File.open(manifest_file, "r") do |file|
    manifest = file.read()
    manifest = template(manifest, { 
      'release.version' => version_name,
      'project.creation.date' => '01 Jan 2010',
      'project.author' => $package['package']['author'],
      'project.licence' => $package['package']['licence'],
      'project.copyright' => $package['package']['copyright'],
      'project.author.email' => $package['package']['author_email'],
      'project.author.url' => $package['package']['author_url']
    })
  end
  File.open(manifest_file, "w") do |file|
    file.puts manifest
  end

  chdir(plugin_build_area) do
    sh %{zip -r ../plg_#{group}_#{name}.zip *}
  end
end

