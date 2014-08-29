require_relative 'helpers'

desc 'Build Modules'
task :build_modules do
  if $package['contents'].keys.include? 'modules'
    $package['contents']['modules'].each { |m| build_module m }
  end
end

def build_module(module_name)
  module_build_area = File.join(build_area, 'mod_' + module_name)
  
  mkdir_p module_build_area
  
  files = Rake::FileList.new("./modules/#{module_name}/**/*")

  files.each do |file_name|
    new_file_name = file_name.gsub("./modules/#{module_name}", '')
    
    if File.directory? file_name
      mkdir_p File.join(module_build_area, new_file_name)
    else
      copy_to = File.join(module_build_area, File.dirname(new_file_name))
      mkdir_p copy_to unless File.exist? copy_to
      cp file_name, File.join(copy_to, File.basename(new_file_name))
    end
  end

  chdir(module_build_area) do
    sh %{zip -r ../mod_#{module_name}.zip *}
  end

end
