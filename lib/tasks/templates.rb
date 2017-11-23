# -*- coding 'utf-8' -*-

desc "Build Templates"
task :build_templates do
  if $package['contents'].keys.include? 'templates'
    $package['contents']['templates'].each { |t| build_template t }
  end
end


def build_template(template_name)
  template_build_area = File.join(build_area, 'tpl_' + template_name)

  # Copy Files
  mkdir_p template_build_area

  template_files = Rake::FileList.new("./templates/#{template_name}/**/*")

  template_files.each do |file_name|
    target_file_name = file_name.gsub("./templates/#{template_name}", '')

    if File.directory? file_name
      mkdir_p File.join(template_build_area, target_file_name)
    else
      copy_to = File.join(template_build_area, File.dirname(target_file_name))
      mkdir_p copy_to unless File.exist?(copy_to)
      cp file_name, File.join(copy_to, File.basename(target_file_name))
    end
  end

  # Copy Language Files
  language_codes = Dir.glob("./languages/*").each { |d| File.basename d }
  
  language_codes.each do |language|
    language_files = Rake::FileList.new("./languages/#{language}/*.ini")
    
    language_files.each do |language_file|
      if language_file.include? template_name
        cp language_file , File.join(template_build_area, File.basename(language_file) )
      end
    end

  end

  # Process any LESS files
  if $package.key?('less')
    $package['less'].keys.each do |file|
      compile_less_styles(template_build_area, $package['less'][file])
    end
  end

  chdir(template_build_area) do
    sh %{zip -r ../tpl_#{template_name}.zip *}
  end

end
