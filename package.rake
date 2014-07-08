require_relative 'helpers'
require_relative 'manifest_generators'


def generate_release_notes

  require 'redcarpet'

  renderer = Redcarpet::Render::HTML.new({with_toc_data: true, hard_wrap: true})
  markdown = Redcarpet::Markdown.new(renderer, {no_intra_emphasis: true, tables: true})

  release_note_source = File.read("./release_notes.md")
  
  markdown.render(release_note_source)
end

desc "Generate Package Manifest"
task :package_manifest do
  require 'builder'

  if File.exists?("./release_notes.md")
    File.open( File.join(build_area , "./release_notes.html") ,'w').write(generate_release_notes)
  end

  manifest_path = File.join(build_area, 'pkg_' + $package['name'] + '.xml')
  manifest_file = File.open(manifest_path, 'w')

  manifest = Builder::XmlMarkup.new(:indent => 2, :target => manifest_file)
  manifest.extension({:type => "package" , :version => $package['package']['version']}) do |ext|
    ext.comment! "Package Manifest Generated by Builder Script at #{Time.now}"
    ext.name $package['package']['name']
    ext.description $package['package']['description']
    ext.author $package['package']['author']
    ext.packagename $package['name']
    ext.update $package['package']['update_site']

    ext.files do |package_part|
      unless $package['contents']['components'].nil?
        $package['contents']['components'].each do |component|
          ext.file({:type => "component" , :id => "com_#{component}"} , "com_#{component}.zip")
        end # Components
      end # if components

      unless $package['contents']['plugins'].nil?
        $package['contents']['plugins'].keys.each do |group|
          $package['contents']['plugins'][group].each do |plugin|
            ext.file({:type => "plugin" , :id => "plg_#{plugin}" , :group => group}, "plg_#{group}_#{plugin}.zip")
          end # Plugins
        end   # Plugin Groups
      end     # If plugins
      
      unless $package['contents']['libraries'].nil?
        $package['contents']['libraries'].each do |library|
          ext.file({:type => "library", :id => "lib_#{library}"}, "lib_#{library}.zip")
        end # Libraries
      end # If Libraries

      end # Package Parts
  end # Document (Extension)

  manifest.target!
  manifest_file.flush
  manifest_file.close
end
  
# Prepare files in `package_files` for packaging
directory build_area => [:build_libraries, :build_components, :build_plugins, :package_manifest]

# Build the package zip
desc 'Build package zip archive'
task :package => [package_file_path]

file package_file_path => [build_area] do
  chdir(build_area) do
    sh "zip -r ../#{package_name}.zip *.zip pkg_#{$package['name']}.xml release_notes.html"
  end
end


desc 'Preview the release notes'
task :release_notes do
  p generate_release_notes
end
