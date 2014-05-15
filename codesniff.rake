=begin rdoc

Helpers for Codesniffing

=end

def get_php_files

  Dir["**/*.php"]

end


def get_js_files
  
  Dir["**/*.js"]

end


desc 'Code sniff PHP code'
task :sniff_php do |t|
  files = get_php_files

  sh %{command -v phpcs >/dev/null 2>&1 && phpcs #{files} || echo "phpcs is not installed"}
end


desc 'Code sniff JS code'
task :sniff_js do |t|
  files = get_js_files
  
  sh %{command -v jslint >/dev/null 2>&1 && jslint #{files} || echo "jslint is not installed"}
end


desc 'Sniff PHP & JS Code'
task :sniff_code => [:sniff_php , :sniff_js]
